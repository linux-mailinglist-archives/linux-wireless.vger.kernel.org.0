Return-Path: <linux-wireless+bounces-35868-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJrsKsWr+GnHxgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35868-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:23:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 702624BF3F6
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B17304291A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E03DEAC8;
	Mon,  4 May 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5lLV8br";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWF8YJkf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147D35A3AD
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904480; cv=none; b=ud5VQoGq+GgMOdn30dl79ezFBK2uvVfYaYoElzFtaXtmIoHKQn/ZnEPX6WQaR5Lrs4xsWxJT7We5Ek8v2iY9RJE0p/+zfLr9ufdGUQutEcBfaI9MbAyxNPHHrvPHTMX57UfOLz3IVc0S7rwOeEbLKD34okRdv9p/k1MXS6eLuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904480; c=relaxed/simple;
	bh=thJij/HpwO/2lGBwdqtd8dMckNVlQ/PrULrKbP8wkJE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XcsbTK+zh21Ibq6s1NWhVi4odbjkENzV/MTMdpevw9dsZ5WkrsaEuYNchBl11UveD1zFR1t3krDS7Xsg1esxn1hI0Vh+B+3MShvHF+GkCbf9OVmM2He57VsXt+8DOY8T7QxNCdR8Bn7cl/L1QdtrNqAeQjsTVNcXrTSGxGkPMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5lLV8br; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWF8YJkf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644DlBI4366340
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 14:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dlXTVI6tE8D6AfR7msWNW1zdKsQO2VMSvy/OARj09vQ=; b=p5lLV8br0Ft0Xo1r
	vBtnrJE4OIGUUHArx04cK302x6A/RXURpmNnZ8nKFpMPgA4BNd+PuqpvUHrRgMQP
	tcUV1xdfUDIAj9VKi2tUK9TEabeAv7dVptVmj4rU33uY+rum5KI0PoxFK5Q+KvlC
	3v/P6rqlKYHVeVQ9RQK8dGyzwKKWaw8O1dwc5x5pUPJhgs+qjHw875POu3eFQF6p
	G3fwK6NNh6tOPKj6nUM20xeTYFVLsRAno9JVOpHnq/pAwE/FsLuRJklP/e4PcUON
	aUd78kQ9zdr8RhQfErgV98XxoZEHNZfgDoEbERJ5kzJZEp49ae942/syL19/q7Ht
	IzmKlQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6r3x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 14:21:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12db37213daso4070117c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777904477; x=1778509277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlXTVI6tE8D6AfR7msWNW1zdKsQO2VMSvy/OARj09vQ=;
        b=BWF8YJkfOc91QhAjVGB+jDrhHgZXFB1QVuOA25Jdna5WqjrvI7gwMd2U075ZN3ZuKt
         KsT79/OpH1zBUxgvzMBIWVnZEIHBo8bkiIWLay9BiKjkroOZ1ETj2Onz9H1wc9B4dF2y
         oqZg6g2TE6Ge3P90G+7OvZqbFIyyh3WZsTOfD6rIqFWkE+0Cko/jfesyTCxTzqPV9czF
         F82DKcNdlEFKCX+1gc2+kolhr8TMzlHPCQqYlMbS/BzReqBlEc2kfGJ2g3QPeaqj3vsB
         05mS2fQpz2LbHuqp+95MW/t5ihhB9XbfF04nnjzlebCqCmcP4L2Ygma2xmcfDI8NW52K
         Up+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904477; x=1778509277;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlXTVI6tE8D6AfR7msWNW1zdKsQO2VMSvy/OARj09vQ=;
        b=YclUtm+VZ7yPmKcy/pbHRM+KkNDzd4tB9JbiFBefyBojyOs4wb7IVvXY4uMWLXg9xV
         YSK0OpMqRJmd74jDnvD1h0cCv/MaldDzjiG2gA0ltG4as3kbV1qQZkxU5D94HwQpo6Su
         HfyKRU0fWpe3Z0Y02dX1lXN+gx9ork9twjpJ4CVsVIMtZtMBI0eZMOGsof8eU0HILciy
         CHefUZChOLfdF88aavjWPKOrDb7Yz+ZiZ3XF2zeJ+YQQLdRvSPISV+eX21PpCzmFQnLd
         xf9EHRypMaPQdN61mMTHEuhwx6kud7Fzkh7ohKs32RbVSNnGbZMAZO5wSiWZkwgoUCBv
         vGpA==
X-Gm-Message-State: AOJu0Yx/1l3LJWSCsApHtTX1Z5xPB8BzcTcIgEkgkq1Xan4SFNpRukVA
	MDkPgRPuFE1Otq8FYa5JjjW2/JXvH/NGB5eB4GlyFbxGGFJcJDYfJRDrnsslHyqdvs4NO2PuFK4
	5U14MialC61tJOCPP7PGtOQG3ebwp14uwWcuw+TZx4blPaW0yrROnVL2Or3Yu6uAp/hSoTg==
X-Gm-Gg: AeBDiesTYwWUMl74nz3928O7Shg+KyCgDvfLeA1oiT/cYk4Z0PzTHizQG3ZOgjUDkbO
	YVjE30gQ0kT56g9mR8q92B7y+cP3qxya6dh4420gsrxfFq9uvOO/SOSNJJGjvqxZw921BhcuOB4
	04xFLtHN8rwnja1IqcvB7ZJsmA9I5jmJz8/Oq88GNtyJeRhPMGtgxZjT2xvdOvmB3Nrpa7vRDgF
	t+xA4W5Wrq+cXOsSS4lobcYaN6Th7cow+x4OuLTgE7TEWtmseXgw+v86Hl/SpX/BnqqhZwoTMEz
	I/Gpyb7qokgU3IhX188RMkeNOttel+AFIv8znX9RSTrjcb0WQ9zabgstl3DhKHJTqSCDz8bp7XO
	EtjeSujcXfChjU6WcFTBmwLi3nyU1/clQolMJoJrrjB3BFEeGNcC5gKRNkUpwsCKSK7feNz7viP
	noIiDK7bYIAvg=
X-Received: by 2002:a05:7022:ba1:b0:128:d4be:7428 with SMTP id a92af1059eb24-12dfd7dc675mr4373879c88.19.1777904476658;
        Mon, 04 May 2026 07:21:16 -0700 (PDT)
X-Received: by 2002:a05:7022:ba1:b0:128:d4be:7428 with SMTP id a92af1059eb24-12dfd7dc675mr4373853c88.19.1777904475990;
        Mon, 04 May 2026 07:21:15 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8452edesm16546186c88.14.2026.05.04.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:21:15 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260427-ath12k-fix-peer-id-source-v1-1-b5f701fb8e88@oss.qualcomm.com>
References: <20260427-ath12k-fix-peer-id-source-v1-1-b5f701fb8e88@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix peer_id usage in normal
 RX path
Message-Id: <177790447502.1253723.11410601963955543343.b4-ty@oss.qualcomm.com>
Date: Mon, 04 May 2026 07:21:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: L1W0H7urKuJF-pExlzN9SuBRWIM-dmnW
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f8ab5d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-unqIoNYWpxd40M8HO8A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: L1W0H7urKuJF-pExlzN9SuBRWIM-dmnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0OSBTYWx0ZWRfXzONq5NCG10K2
 T6AqABDs/6Sx4tUyGUJZ3S1Iwi7+V01PDYdlUhXqn6wcpzeEgI0Ae0/WY+4h4RfVpZ3YBauIqb1
 PMOxa3+S1kh5hwo2Tf80U/5DXroiMCETXKKr+mEsrm3RoZLxY5BBCBulnNoZl1HxL+O5SH6nIhk
 gnit/y8WELW1ZZNHMxsWyXjUKRBvpnSf3CMxH2jyeFss96jzneI6//Qls9ynh/EByDrmRHndlHJ
 3gSPuJ9qBIMnPuNtHeILhBSdMcVyoRali+3f8pcEZTdn7iszMHE0JSkRDJzwlWMFSXjF9AWS5nn
 WH615q/5kIkVSXKmZOPIWM/CuCdiP30xt/m5q+3d5fo+XElLdqUBGD2B72BWJqgFdlQ0ykM69Zb
 dKzlK6p9/cskDzetKJCuzipXaC4zYboMqFPtqjICjAEiQH1qdiasNG9+YpEl6Y8yiIfq7zu/ds4
 Y1xvrN2Nu5kymvOxWZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040149
X-Rspamd-Queue-Id: 702624BF3F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35868-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 27 Apr 2026 13:51:41 +0800, Baochen Qiang wrote:
> ath12k_dp_rx_deliver_msdu() currently uses hal_rx_desc_data::peer_id
> parsed from mpdu_start descriptor to do peer lookup. However In an A-MSDU
> aggregation scenario, hardware only populates mpdu_start descriptor for
> the first sub-msdu, but not the following ones. In that case peer_id could
> be invalid, leading to peer lookup failure:
> 
> ath12k_wifi7_pci 0000:06:00.0: rx skb 00000000c391c041 len 1532 peer (null) 0 ucast sn 0 eht320 rate_idx 12 vht_nss 2 freq 6105 band 3 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix peer_id usage in normal RX path
      commit: 0e1308803d2c3fd365a6d21e6be355ec1e28eaaf

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


