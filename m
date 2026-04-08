Return-Path: <linux-wireless+bounces-34495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLbyB1im1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E213B5C41
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7987301AF6B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFA26FA60;
	Wed,  8 Apr 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJJ1fqyx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cYeY8kDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1710F1
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609429; cv=none; b=neizbOy44DlEqGSpMXBOVVPYv4ZyuIv6mgUvYlXrGgyZ7By2wNix794gP7UNsjLdfnGTKtm2dbQbO+D5p2d82fUZQ/YmjE6LA0/5tZpatzg6BAzxu/crMQic819LapVEG3nMnuVPb9htiqJTV1+U1DpCP+7RD0VbDsUxSThHMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609429; c=relaxed/simple;
	bh=YG5r+zMOrhZsHFPw1jQW8OPvxHC/XSTc7+JxyugvymM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z6T6JPq7cPUQ0NExXZ1b4BLyvPMnbuASUiWfPojBanCzOonFL/+Foh4eYUDlb4xv1UP9kpy7Z6QcRXQN2mnBqH9AT0T8AFHli6oY9g+GBZl7jcFiC7QejTvDjp18lF3X7ykIJAO2Q1tDp4fGQLGedJAIMld9KP8hZJNPBiOGvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJJ1fqyx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cYeY8kDo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637M6KvY2450557
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vimRX9C8rZXo7kyr6AmQLDGtvwOIoGfnY8kE/ALqjNs=; b=eJJ1fqyxXkwb9ol6
	of3M6Ursf9hiGOFuat1XokjgEFkkqadF97oNhlncIbDAigH9wWgXMTqXmzQyjyTv
	oPx4okJM3zstjAsgs5Jhe5alJcuSOQGQPSDLwQb8GAUYD2EH3njXBYim6+qbRpBm
	DX1THn895jQaAVxySHZnMbv/FuRPQUGmmVJIJuKv/eG8y5dGetTeZt3NBdq9wG64
	UjSiHxK/w4d6CHCtOtbbvtIbrokONoMhM/a+FMNaXay7O276+z1e2jYx5gvR6jXS
	LZ4RJScDFfut3u/yFBWLyWwMh9ItwMPO/5CTmVoptth42dLtOK1VGhRDkoQJZ8uh
	yYPEOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68bqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c68a134df8so5387381eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609425; x=1776214225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vimRX9C8rZXo7kyr6AmQLDGtvwOIoGfnY8kE/ALqjNs=;
        b=cYeY8kDoto2NMK3jP00HXHFSF9VTRI2Dvmqignzbug2slG/6TgZeQxM7EcSE8p99c/
         Ssr2CE/n3OEdyoZEqJkCj5XTdFkcDkyl1wCz3BWQ1cCVaFZvSL+yEstbbuBvRRO7YNkx
         P8NJSx9bpQMmLWcpA7vsVeS1pJGwAPimRVr6hD+lpLBVxruoEAm+W3Y08SS+fcJkFIHo
         k4bbvqapAga4907BSzbyx5Q1sRdaQOx/F+IGSnd6zOh6Do8jQ/Itwqh1aCKkOdpkMdTA
         Qed61vyEVKp71Z1J08Q+M70etnPSwTTCaWt1gmh8DepjdNVIa8XFlMTXbvc/RaspzciU
         uqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609425; x=1776214225;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vimRX9C8rZXo7kyr6AmQLDGtvwOIoGfnY8kE/ALqjNs=;
        b=J+tOjAL4p0RXJF/eNncjDRym7jjp8/EcvkTlKBFyh8L2/Qrjh5paCGmXA7rCWSKVEV
         PbP8208Z23imp2f2ZHb+psT/xx77QFRXRjloj8jEoHChHEK1GBmQaKFMgb8jxCEgrqmf
         lV6cEAdhG2Py81nvmMWA//+/bZkdUx+ANkv823m2fgTInV7PMeIdHcZ3xXVX1Wjb+yIo
         AxBYOXHcThdzF5yTS1TnXUjvBbTgRulJoHevwd76py7gWNowvg4pqNYhzxYms8Mn2NcR
         WgM12owqaE3nXliV6Fenc0KwM7rXtUtRoszu0QUoPWNB3qGTuGIpc6aaoT8F/sId55BJ
         cgcQ==
X-Gm-Message-State: AOJu0YwhxvgE6Ld7bTli+O5d2mxJMA/MbJZpAc/hmwJnBCrJIi+nAzAc
	EDHSMeokhp5sGAFZAmDS/Ecehx0TET6Hej2BsH/t+SnUcFFGnFg5bLas255TcxX+qKJUdKN+rOZ
	T8/jKlgbZn9QY2Z0Iv5CyCsag+2RNvW+XyX0QRwzG5mlUqICiVypIe92/7425saCtjF5Kog==
X-Gm-Gg: AeBDieuEK8O+0uWLUTOGv82pzEUubs5Id2OFwmA7pPXIL7POI7ajouc4kU1UWupWtNb
	By7D756uFhLrYqFQ5wVUVdyIFmjiMRhFVk5vG9hZ3FTbOECFmtAL2OCdg+x3WJSqawHf8SEiE4t
	U4h2wm3n9cSVnF4ek7b6KINlvnJY9b3po9c+17zHMeZxp8JIW3a3S3JdRqow57bMM99vw7EAWkO
	BsMqHdbE5jo/kEtQY3m9Ccg4sLqdFn/MERpy2xCYmVjfeoQOHLJFHRNi2KIlOYi7CAommEKsCli
	tHLyTP8v6rhqfCOvXTU0rCD5rjswlrEYn1KKf2OUuo5dtgIVBq7YKwPv4lnvAAP65ZG30ib2W/3
	hMTX2mkniKga09ut2JCznJS5AOpX6BWueZNz15K2LcCV66DHN5mrrUqhzrde3D7ymUyM5Vpe/Mg
	Mv
X-Received: by 2002:a05:7300:6d23:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2cbf9fe2d96mr10104013eec.8.1775609425404;
        Tue, 07 Apr 2026 17:50:25 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:2a4:3593:466c with SMTP id 5a478bee46e88-2cbf9fe2d96mr10103990eec.8.1775609424539;
        Tue, 07 Apr 2026 17:50:24 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:23 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
References: <20260331045834.1181924-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Rename hw_link_id to radio_idx
 in ath12k_ah_to_ar()
Message-Id: <177560942382.2878209.14614851259442358560.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX8S7eaYCkzEX5
 A7qL8uaJ1qLJEgeDCqnUDBDUKFVqU81OJGDymopvvpR3SNNrihzhueBpTsOAlhQXzOxHZzTexL4
 dB2rClOMy9zySkRSuzKHQSxHcPnwXxYgpN202Hrnc6SHRHkzXsEGa+3haUdqx9sQayKeNMzJBQ2
 NU5qDB1v5vMAfxrDLW0eQXstZ+XGII3UmIsWTrFXmvn5C9bIWEljkW0l33K+p+k5dDkyBfLWH4d
 i+uv95jCT+AeH76sbWHmeXJkCkFrSv4GR8waO8arnI5cj7pe1l83iLN2r6KuEwCCi059UEfw8Pe
 cyS+s4LH/Azg8tjPnTTQZoQ8yK/rVYMjmf2bfQ4IaVyuks+dF95MBQHIoPH91Ida25IVAK45gzk
 mWWWJBB9PonEaRlIeqjgal5xNY2PVQyxXfs5PyXZdkBfU7xQXxHXkXXFq5TZny5QF+llujuUxkH
 bC1qWDjJeeX13V/m4sA==
X-Proofpoint-GUID: b6EvPPSz2Y88rZibAlsmVc0upo_8-zsN
X-Proofpoint-ORIG-GUID: b6EvPPSz2Y88rZibAlsmVc0upo_8-zsN
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5a652 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mRwJYgxffaLpAow2y-wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080003
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34495-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71E213B5C41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 10:28:34 +0530, Roopni Devanathan wrote:
> ath12k_ah_to_ar() is returning radio from the given hardware based on the
> radio index passed. But, the variable that radio index is received at is
> wrongly named 'hw_link_id', which points to the hardware link index that
> comes from the firmware. This affects readability.
> 
> Resolve this by renaming 'hw_link_id' to 'radio_idx'.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Rename hw_link_id to radio_idx in ath12k_ah_to_ar()
      commit: ba563287beaa99c18144b2e39f63b89412abfd18

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


