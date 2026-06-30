Return-Path: <linux-wireless+bounces-38408-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sWwDDYQ0RGoIqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38408-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4996E8217
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jOsGcm0C;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AdvX8e31;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38408-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38408-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 666833054EA4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F71A2D5C7A;
	Tue, 30 Jun 2026 21:26:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58BB315D49
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854786; cv=none; b=UD1mGcWRRgasmKPcXZ3p7cxwaSUd5ZOAIoMhxJdpvf7d4P8+ugg/KLcAB1YrXyzZLhieaEwaS3Vqnf4qe63XFg8i2pNfukJdmc/AmatwLm61LNgSVdDqvzLEUSoSs0Q3kfhq6xgaaGODs2849MpAfNZrIGrrgSnJQOA2p/RdERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854786; c=relaxed/simple;
	bh=lZ1Qh6lQEwUvi/AvmF785S983e40MGBavUkpGCDKufQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jc/VsUyJO/kiNebKteNpmigoHqYCJcKbbon7hHhvFro59lbmPUBUH5x63CphaIsLcMANWJ6OvMM95QGL2bzbBtBUXcKGbEsHEUliJrK05BlHBFgdigV0xZexR4j1WHFRuAsH9k4DvAo6H2ziLJ8Qqz3X4Ks9pmYC13nlIeJziUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOsGcm0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdvX8e31; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDkFh2879979
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jLor2fs01SMFYiijG/KuA5E7zh5MzCRC3ggS6fY0D5s=; b=jOsGcm0CaPyVza8O
	Ww1WuQE1f0WcW8VtrxPOSZLP/nycSekeIXAudNwIjzmy7YOT1367TQccNj9xlB1y
	sTH0cs0RqywvxkZEuJ9Jtb6KEvQ7UvP1VD30q1AJ2BK4W3fdI0MVbmuZWwmAgGRX
	0VhDdq1IzF3Oys+EWMFTmRs2yL5Z+4yPBBkCE2OglJgkpD3xY0e+7WY7EN1gpIZN
	I3jUWkKKRCB5FKN7Rm58H9CxUy1auWAjjN09unLLte+mjHaHWHD8/hJqIv1R912F
	y3Nwn17CSCg78UTk9Kri0kc8aO5jSZan4pemqOKCw6M1LpCBOqzaVOjO2GOWz+kA
	C7iUaQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy9900-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so859675eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854784; x=1783459584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLor2fs01SMFYiijG/KuA5E7zh5MzCRC3ggS6fY0D5s=;
        b=AdvX8e31Mhb5YT8sqOzMzJX/vZTIERINvC4CY7vF5DzpK14mZV6e91/kuVQzT8orwu
         UXhju4iDfby31OdzxhcGQIUbeGNMA0Hopz9SV2XubS5Lx07N4t9So8+u1giYn3HWHUbb
         TFM0wqip7hIAIrZqCGIKSj5pqtn/YoNzf27Uexfs/4e8lc46n/JFgLC2mfxEq+AW2cF1
         UR5EoYnryRq4DDERi0zgaa8DIAzzH+bZsHGW+4lutNBsy7ShZhSbpMBhpXbApPC3zoG7
         WssocSy/EmvRE+3svMZ08usFZY4td0ELa2zS1ObTYXWROlssRXoQ91iP4TM/3p4wfn+c
         K00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854784; x=1783459584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLor2fs01SMFYiijG/KuA5E7zh5MzCRC3ggS6fY0D5s=;
        b=fbHihnTUjYNhtslxWqy2z8a70QZGQhVDE4wj/UfZjVqqHvJoXvrq6dO3CVP59iimrB
         sbeKSj8eGpSyVZNTSl1noe1bS8HuKgdmDUCSaz09/Lv/edJ0KnNehRZXLu1Xo5OuM/yb
         en9NUQjf3zLgSyfRYmSrAt9d+PcP42/P8AXR3tDBrWR3EZB9bvMnGu2Oc7f42Cn5bDXa
         XdJGC7/PzKJbqx+SnD9FFu12XDd/bSPx+kebcXwKWM6ftOaUNzfbukfmr3qJpZfpWiff
         jWZs1Aw9VuNhlFSDJZOLnzYWbeuIq5Z6bv0YtPKBSwtB705JJwNy6aZKVfY2aHvR8FkO
         Gp+Q==
X-Gm-Message-State: AOJu0YzY2smvXunbs4TRmdaLbgXfDXdq7rj1hgeFWI/lJTvqAa9udYV3
	omZfKVNfllOJgGwiK+uWOcUYUl0Ehe8jYgmcyyomBVkqYWx16DbyM/bf7F572/Y1xp5zD0st6HF
	IAEPi1FXeywlhegrdyZ+v3K+BUczjtWBiZtP9T2anr5nxjDjne+LqsliS1xNkYqI1VSVRAg==
X-Gm-Gg: AfdE7ckFojaOruczzkARjz5CeoY/fsxlIUzAPbgAUVEhPJ9LkiEUDG9A4Sl59rVQEg+
	tLAQx8o2/Pn0GTHG9PrMwhZ5NLSjSS1iZHYRlWdvtwbK9rb9J0RYN9+EfB5KrxXenkjU79/HAPZ
	ozyKO8SB5U2V+S88PCiGf36t3T1Pj8OFqPbs1b/OQtdjdkIOwqIeiTbVsdxbPDP57v4agvZfUf/
	cXNZDfHzPl+J14D6zshm7fnistUuWP0eApuwSzFh54j9sUEGNv6ZTF1rYwr9RhepZ8Sv1WV+QLr
	Vrb69Q9HTcOlT1+u3bnGhb3DN84ki6rl/nzbmzbinZnaAll9z5TCKJ0riSip55AylIEYirKzTax
	LrNTeo744O1oIcNRUDcfwcEHH90cMmLRlcl4bZS4u7eysDrWNbY0k/k/Nv+9idBaENQ==
X-Received: by 2002:a05:7300:6c15:b0:30c:c3d:bc0d with SMTP id 5a478bee46e88-30ee129b412mr4331384eec.18.1782854783896;
        Tue, 30 Jun 2026 14:26:23 -0700 (PDT)
X-Received: by 2002:a05:7300:6c15:b0:30c:c3d:bc0d with SMTP id 5a478bee46e88-30ee129b412mr4331355eec.18.1782854783336;
        Tue, 30 Jun 2026 14:26:23 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:22 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260623035104.3765404-1-aaradhana.sahu@oss.qualcomm.com>
References: <20260623035104.3765404-1-aaradhana.sahu@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: remove unused QMI definitions
Message-Id: <178285478229.1590147.2490540911535739296.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a443480 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 5aH-0urnO9H2IjQcVQ7PomKkgsAAuIk6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX5RQk8EY6Ujtm
 Jsbqt7wZBwCbO+GbrksxCyt+AriKxiVK1m3cOUG1Y3GxflCSN40jB5o1lPr/AaOoKUTEQiO+ZBV
 xBu8UInFvqQV+3u7ycfaJACNqao/96c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX3ySL0Jyvjt8s
 UPSC87zXOpT+xn8jrfdiUkKCbcicig4ZzNT5nTBiVurspUyEN21AjAz3L5WqumCtUOdt6HGbFtv
 7vwbYL+FA/CD5tv2CjZ7EBjcsnJr21CjQgedEWdq2NEZuWh7y0ti+sLnR7ZlMVgRzPigPpH5VWT
 mTMnjVD9LhAuNAUWMOvDfe+uWTKKcBx2gzJU0JpYS6cklh0B9Ef8u3NEu+4RWzQA4aVzIanhkkE
 olaCAg145GXzBqbRurAonBvbDpDDishiujVvnIQ2+J4auQD/lDYwIJLGC1JonFv6qo4zl0INI7g
 yMmon/y5JkpBYxgxtral1ulUK8tDH7ZdirOrgAZ9jfYVEmsYaC+6ZId4N9AKa/Pi5PzMpsgXpoX
 Z9LON4oZMb14u/S6mvSf+rVsnbmLDkBZ7rMEb6wcBc6IKl1eAFiBqlfXIpCrt3q2zfdmN/tpmiO
 t5F3ZNT7HQF1mxfcnwg==
X-Proofpoint-GUID: 5aH-0urnO9H2IjQcVQ7PomKkgsAAuIk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38408-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:aaradhana.sahu@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED4996E8217


On Tue, 23 Jun 2026 09:21:04 +0530, Aaradhana Sahu wrote:
> The driver contains several unused QMI definitions such as response
> length macros, message IDs, firmware segment length definitions, and
> CALDB address size definitions.
> 
> Remove these unused definitions as they are not referenced anywhere in
> the driver.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: remove unused QMI definitions
      commit: 007b638ed7242daeea7c1078e8f732d127c790f3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


