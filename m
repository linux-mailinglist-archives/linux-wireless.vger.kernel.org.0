Return-Path: <linux-wireless+bounces-32231-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODBtNBu8oGnrmAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32231-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:33:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 380931AFDA3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 22:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19939310C394
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A75427A05;
	Thu, 26 Feb 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hOl2TUiT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrlKMLLG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411638E114
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141356; cv=none; b=WOJtVca8oCNGi0KiwKGiGbJpwU9Bq8j+DG/ypCw+BAZdPvGQcueCK3Mdl0Wyv0oXgXSrIL7SQ3jd/WR15DGUFqU/8n8AzFREdocA6slhmdjw7KeHEuR4py7jNeJPnQmMIWzNPC7rs1dGMV9RvU38VYjr2YaWcPb2UiuyBwQiAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141356; c=relaxed/simple;
	bh=HOS7fqNwl/UNHBvXdHRbWz4sILLPxFf1QC+hwTOGeXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fiF3TicyQaRForhPNNrW6GT6SkUZS3kaJPJJ3YgbsUIc2SYcVJIa6CiJ+82Ev27mlxCJsC6pRcmctBj7016jBdCSeUYqRN08HhR3NRs3ise4awHcKUR41tknjoeJ3I2NHhaQbN+droQP9yzDrcV76aFYnTi2jECyGkcu+eUYqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hOl2TUiT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrlKMLLG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIrUK82807417
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3mM98ISQinZlQlT8uNtOxm+PjSrQsWKHt7t2eBAOLhE=; b=hOl2TUiTHPbSNGog
	YtujDBcgKQkiyscrjC5RGaU6yztHw56zhDwd0tCgqQ5t3+F7MSlooTae8IqKl53i
	/15jfPrjKXIfTz0e2Ezp25WjfGbBhGSpa44hTU8OjIpl+uwVa31jS0005ZQEvwpE
	JjSQRsv97IC5nEezL7uOvG1QSDcrTYIlTznNUo36OdgVfKuCYiSL0kxwnZLghgvC
	01Eh7X/VrIyWtuPXTkZBGhzM5E9NNTP7ATqY6/VVdlsys4p4QBVIh1QmG027x2UZ
	ACJlY9rPyWd670/5wq/KRThiR8Xc5X5luRmaBRpUAUL6XL6duaur288ZRI+OT9Qh
	XulYdA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur0fj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 21:29:14 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4ee07e31dso34217479a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772141354; x=1772746154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mM98ISQinZlQlT8uNtOxm+PjSrQsWKHt7t2eBAOLhE=;
        b=ZrlKMLLGA7VE/J7CcVYhoEPJtPh8HAkwfh01mHiZmdDo7Z6Xj1Nwqmp9UIFqM05/G2
         rc2EqT1PHZKKeoM+3x20+A1Y0s8Eozq0WoltrCThDVPvPQ23IaPKaSD2WUZKzAPze7Ju
         U1jHjBIXMGBYf6izXqAswVIcXK7j/Nwm01uQbMEwv31RgY6qnEoZliy7/THP2hT49eX+
         rapcCzZqC/4ifbENp0dAlywGXKqkF2lyKai+g3I0201lSxfwn+VDVNCLNH5BiJKNbAJR
         Q5MYHX2O7EX0dBJ95zw9iPBoSLB5GMg0Bagv76AiJhra/XgH8m01NTclvlaAJ4Fy89PM
         a8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141354; x=1772746154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3mM98ISQinZlQlT8uNtOxm+PjSrQsWKHt7t2eBAOLhE=;
        b=OFDAWYweJJV6Zl0XO39+nRouCcHTd4aeoose2LRODxWBehcRQFGcoe1rLxUX6WudVx
         f3F8PgxeugGQpR6jXDb1uRAS4Dp98J7P5ZBP4TKP2OSInOVEz66JpAk+qOFcsPxpeX2g
         4nIOky9kBH04W4Mtg3vrm2+ai2/zGfW8l+pGa1kWfyx9LWMRrTiGgvNeYVnPyl4AGVXs
         jiYiMqkBxV2bpNpB2OY1VS2+8AJTTbcu2oiE8D4ZeqeYRMfddCxAYs7FocQy3Rx5wcvP
         ct8Gwyt284cp6bflsWVX6JE0tWzw0j7GkBmB5TGoSv1Jif58R/QJwrqTPkW3vcwkjyV+
         OBTw==
X-Gm-Message-State: AOJu0YzZg+Vx4lHtUaV8KmhDPEN1qTZ0NKHctZstiNJm28ymW37+o7eA
	n/t1R4u4wkWZbno+V98WGk2fU+QT1DLHXK/anPplvvXBH9qqIx81VRKb/0iUCjmT+aDucqZB6Et
	KqzKuKKKQAUOGBDdUv8rKW+0qX/e4VJLQiSCmK5FRXaS0mV4AGG4tfuCqgSLDTPOuhtt2ng==
X-Gm-Gg: ATEYQzz5MzanPZ+CgG6tUvQrL0BhtXB3yLpCJQll86L2z81U0C7hSmQeE1KHiyccnsu
	A0UyakvbgWE4g+BK4GalyG+VhbL7ahRlB1M0z7fDckjlOhynjYj6a71a/PaeIzBaR5SIjry/piG
	RW3UnfIwE6h63GeceEQsYu2/9jZ5lfuLEtHEkd+Lps3MXFl2sM3BsnQKc4uTbUUl79GhUqgYO5z
	hBwi6XewqvakENguolsIQuhaOqUJ51fEoY+dJ+N0PcaPFN0XAnlO9eByLYfGtpk9LTGt0a7sgLe
	eCxPJLRvd5Ftwq063pFjr6LZMDvzxSECvJP1IuOx5x3kcroyC8Qn1j58mvw5dusQVVuM2Xw17lX
	etwMPjdqgBlnEks8RD2IXzQjsDToYFTOM6bAESj/OoDhrTPJ52D7x/PWlQNB91ZxF03i1eLQsr9
	TE
X-Received: by 2002:a05:6830:44a1:b0:7d1:9574:db9a with SMTP id 46e09a7af769-7d591eb98aamr374847a34.12.1772141353909;
        Thu, 26 Feb 2026 13:29:13 -0800 (PST)
X-Received: by 2002:a05:6830:44a1:b0:7d1:9574:db9a with SMTP id 46e09a7af769-7d591eb98aamr374831a34.12.1772141353327;
        Thu, 26 Feb 2026 13:29:13 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2866703a34.27.2026.02.26.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:29:12 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20260209-ath12k-fix-indention-v1-1-6b87ae99745e@oss.qualcomm.com>
References: <20260209-ath12k-fix-indention-v1-1-6b87ae99745e@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix indentation in
 ath12k_qmi_aux_uc_load()
Message-Id: <177214135217.1298720.4558552166539751688.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:29:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 2mZciNjnm4dbhbGjUbcgIh8iVynlzCt9
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a0bb2a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=i2l99LBLotoStgmZAKAA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE5NiBTYWx0ZWRfX/ASl8hlnnfME
 bUe1E0IHS1JO9t83/IL5o/BC2XdLpzbvBYcOIKLyPyd+UNWQBPi4u8uA4JvaVFWdM0noiv7AMHC
 tkaf2lHNSUZdleEcUCDdwniCQ1iv+M5Wi9oEEFX7L7HYqih2SbztYL7SanDjg5W268xb2iwydbj
 amYulyy+zGV5pZ6pJPJothPyFKxW2T6v78sljiZId1LWdSfLxnXHZdk9XVwd/lDypXUv9ereh9s
 w8vboEfJE5s/XfRs9iCSXTLMAk1r+dpNgHRMBtIRttlL3Oz00E4DmLJWvY0WR1L381+VOBLaiiq
 KTajUgQsDtyd2kD6kjDnUcq6R4e844EXeyCczyl5qBusD+lXg6L8dvnuHomb+X4YUmqJv2rRWns
 uydtros7MBoxlHAI5lmIqHj7k4VyuAydysy2kyEgnFEfdPItho5GAVFEBgF1+vuDlFVqUKtC6EK
 MtOaDDQyKAvKFHMlfNg==
X-Proofpoint-ORIG-GUID: 2mZciNjnm4dbhbGjUbcgIh8iVynlzCt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_03,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260196
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32231-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 380931AFDA3
X-Rspamd-Action: no action


On Mon, 09 Feb 2026 10:52:19 +0800, Baochen Qiang wrote:
> Smatch complains:
> 
> drivers/net/wireless/ath/ath12k/qmi.c:3342 ath12k_qmi_aux_uc_load() warn: inconsistent indenting
> 
> Fix it.
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix indentation in ath12k_qmi_aux_uc_load()
      commit: 0ef4738f0d38f103e525ffb12c112a935c2cf011

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


