Return-Path: <linux-wireless+bounces-38412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +NqSO6A0RGobqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A10EF6E8235
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bSoEye1j;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=T4DSOsBS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38412-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38412-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AFE5303E6F0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53831E828;
	Tue, 30 Jun 2026 21:26:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF922E736F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854796; cv=none; b=hNGXD/w/NDX0KK8jsDiDJ5LssoUySlBP5BSD4q4y59ZzCZ762Ecljf/ZTH6HzhMy2SZk7fHA+yfUIpB7/I+Hc4s+uDb8/9gGT8QCNgNxGkzjp/z9o7Q/0diMkbBydjcgElyBXrbJqkn96sfh4kyEMK3nwVjKjMdGJBjsozGtySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854796; c=relaxed/simple;
	bh=Qez4ChHC7qNuZ70/Okx0HiHq7supivqQ48S5CpjbatE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HDmRLe2rbFXT+yz7QH1Gvg5tODcUSuxhTJ4chw12rfSFZK926r/9C9Jl4b2LKlNUe67OTzgN5WSbGbj9g26DWHNigCN5/og/o4dwkcXLDkeh89ZDeC8iU9U2cB5cYnn2B3P0ja8D5eJBAnberbM509weCwkqWP9VGXm6pMAT3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSoEye1j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T4DSOsBS; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJE2Jr2838807
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+NN2NzpxKurBEiDtqX1Q065yz9/UoNGy13KR5P1bdE=; b=bSoEye1jR+7EVMU6
	fVNcpZ7Ze79hC0KVGL1hR2NYZGZfb2QlFwqxTwnWieXbWsuMAyEBhB1I1uo+0s2m
	sIvIkWS3gvQo9cUAIlKSFRKLT8fSZJvyjUJgOVbn2JnSorHY40+zy0MkjyXe/gGW
	elIUwYpZWFj0EHL4fcE+YwGG/a6ikE7MKUElQ4KzzzFRUuTdRvVZwtJDN++VWxY4
	wGFcWwmLNJtsUVaU6c2ZT9MZ8QwlC9DcWY6g1RKswPiO65NZZxIamTOoYrYvbopm
	oKtXfDz85Q76oSMRVv3J6v3ShGXVX30qwBGlbbbkOP2XNr1HvN82LEYZ1avAJtHA
	CT2dxg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd1bmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c1f6c5559so244751eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854793; x=1783459593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+NN2NzpxKurBEiDtqX1Q065yz9/UoNGy13KR5P1bdE=;
        b=T4DSOsBS9h8AZDEFI6tXxXbsaeYtdK4O1HKgv0rPqFA/jUAsMZN9gwqCnfNl7guo0E
         ixfuW+BX3RgFzeeZz0HnyD6MW0KKT25bh0Zkbqq1W0j6yTj+6WW2ICq2dmzUx77oRLxp
         xamI6TlFPei30uQfOnZ+huY+C184cBIPXnDxwnGMhJnEl6VeqLSPtJfb+HakHx801sfK
         fC2a18ay6mkOsY8n/0FBEMI/IIEZz82hSUUUWVdycq1EVdVbjr0k+7R8gE4c5L5qAVQo
         GVSE6qA/qCLQpc5led7gTjay9syxw4GQCceAUEN7N1FYnnfYHA86MlRSROLzJSiA0ebO
         n8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854793; x=1783459593;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+NN2NzpxKurBEiDtqX1Q065yz9/UoNGy13KR5P1bdE=;
        b=Fvf+4hAGoMtlsOacr800c4DIqntMFDIx/Qak4tnJZOt9xGfo9kPK2MAtHl4AU2o5Yn
         UIm7X4uTBDY0GAGSXJE50OKxis1fcDVu37AmLiwl0ifb5qSTK/3crzb0HbAvj5WDZiUn
         vBPbAZ4yg4IFoqgs034R4VOTVtHUlGtLG6BBrqEL1Q23pZKxi2UdSYPDQWjcOWi8EQei
         6m73PKxzslnAPx2S3YWjzPika2lRxBPH9RloULzdBQlDvSKIN7hToiv5YkEbRvjS0/AM
         gzulGJX8EYkA75d44D1HTe2v3xGn8ElkSp5cE2If44/Wy0uguWu3fST7tbNgjCfnR5KJ
         Uh8g==
X-Gm-Message-State: AOJu0Yxjpw+nQ//1js1X/DeUNRt/ewZzs2gY6E6U2c3v15vk+LD+Qna2
	ivl1U/JPVRcBY6Wt8FXKki69IvfjEskHRY5aFcouFDK/SVfyeJLtyuGpTOSSaDOIaRaEfRr+r46
	uIt2lOABNnlfsXEfHnUt3w2asAqOTsvRUrqm11dbDXVzJ/NZFG23hpk2OsZ9KG7TCA4kSHg==
X-Gm-Gg: AfdE7clbXyj9NWOvD4nUN3ihtlHOqbnKHrH2zawMwEqp1aGC+9Q44532Q22i/xnUbUj
	Tw5Wd3bgsVh3pqdRlOEstP/VTUWX/HEEVvCjB0NhF1llHEoNRG6LefrXdxUCA+GTdaqg78bL0b1
	gy6slkpgxBsJ37B7Di1R8aDlr3t8URjW85R6Kgw7C1sV+fjrGno60pCJjr6BJs4q5uZIvtW9Xun
	si8we+PFfAgXY2Tcl4br769KzLryA6/TdItWswWnkMMrub0PSepC4d16sR4RAiKUSr3QIEz31d0
	y4zPRm6Zu2a8WF81pdXcZT4V2JDvLlqjm8B55ermZcaHqLro2/LaBnqUAb8Y70H0X8cayYmQ4l4
	+7IrdrCeKJ4/4aJz4fwSeCqIBeT7UKhn4iRhelEorVVq3qTXzib/vo/5skgRAGuZSiw==
X-Received: by 2002:a05:7300:730a:b0:30e:da28:ebf9 with SMTP id 5a478bee46e88-30ef0976056mr1966607eec.21.1782854793377;
        Tue, 30 Jun 2026 14:26:33 -0700 (PDT)
X-Received: by 2002:a05:7300:730a:b0:30e:da28:ebf9 with SMTP id 5a478bee46e88-30ef0976056mr1966590eec.21.1782854792829;
        Tue, 30 Jun 2026 14:26:32 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:30 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, P Praneesh <praneesh.p@oss.qualcomm.com>
In-Reply-To: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
References: <20260619120751.363340-1-aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: reset REOQ LUT addresses before
 firmware stop
Message-Id: <178285478993.1590147.14177181473316715815.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX6QDBSFyLDGNm
 lSgUNOTAiygLXARhCNgxWAJY+6/dX/AVNw+KO5lIvnnhdmKB2mhK8BfAd/R82XhsxzM7H7DBAgz
 bBhhdt+ee7gouWkdy/hzWIJYlL+rm2k=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44348a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=CtJ01fMn697GwrxBsWEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: jmvT1wajSTSYuhD0RZv8qJF0u2xFvBHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX4MreS/CTMph6
 O+lUZn28HWBEhAr6HdUBFpAFiHLGfQny6LHYY91bvKU/hxrDL0qogsuY7ykXV67/3XZM0sH2SXB
 cx8uli61uMUbIN2vOCvFz3xKFlfMQ84FAO7jy/TanueQlGKPfDFiJqR/HMtQtrjAmK6WoBsHlfa
 9pQaFOSRz7UHcZlwn9hfS/Zqo3+nuWMEOwRIYDAd/033rL5wD2+SYjWBDUyDKmGW5goB9eqjtmb
 uPTjU4w8SzeQGny1NdBXHZwbxqiDeFv6QjRKFfFazpHBcagpyL/v34HYQ37UCXcdFjkMTFA8a+O
 2OwOYTJxJjOzX7PGFd/t/lScD6aDzZ5PuEJkwephROF43t7CJkYO9r3cDpc7RJ7/peW+8Mnbv5V
 CbAA8+wrz2bvb4dYCJszx6g0iDBTUzprpLs1xMm804mYrh9SEKHwucUzGoKNQn4F+68yTGEarG6
 vX9Khi1+J1ulvQhLckQ==
X-Proofpoint-GUID: jmvT1wajSTSYuhD0RZv8qJF0u2xFvBHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38412-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:aishwarya.r@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:praneesh.p@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A10EF6E8235


On Fri, 19 Jun 2026 17:37:51 +0530, Aishwarya R wrote:
> During module removal, REOQ LUT cleanup writes 0 to the REOQ/ML-REOQ
> LUT address registers. That cleanup runs from ath12k_core_stop(),
> after ath12k_qmi_firmware_stop() has already stopped the
> firmware (mode OFF), so the register writes can hit an invalid target
> access.
> 
> Move the REOQ LUT register reset before ath12k_qmi_firmware_stop(),
> so the registers are cleared before stopping the firmware,
> while register access is still valid.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: reset REOQ LUT addresses before firmware stop
      commit: fe2b006c15f6b1f81524b4c1af8013bc32fa0abc

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


