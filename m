Return-Path: <linux-wireless+bounces-28420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F48C227C6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FE6A4F13B1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61A337B8D;
	Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rai5WUjs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LCSvjN5l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D833335576
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861465; cv=none; b=BGLDV5u/i57FF7Q7eD7pBkFVvNGyLd5gz5Px7azby+OvFDmNoyBinRItTf/QBeuQ4Pl+4cOLnGVd6pUMsiIXz9+2ZjJS/8hSQRuZcMgbBffBdhAW4EjexYiJsbAc+bRXJXLtbdaRGEK5LVC+QHxl2X4u4u8q60QZxLI3wezzQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861465; c=relaxed/simple;
	bh=7T+iqynF9HbUHblmmwMTUTplDAva8M13bPS7hTBhn2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T7l787BJHhMdUQxD9UZ50uhWZZW2tgFUmCTJfl9ME/Qn6XRqmu6vDJ824kfByCpyM9jV0agWbNWoxkA4NP4Yhyy//T9I8eZf7dWHLfKOJiNbER68Ajxy8x7/OVSKaWHrXR17z5c6z/aVEZGN17icATSSCVp86IWt1YHP35ZrrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rai5WUjs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LCSvjN5l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UKsQlg832852
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qgdp88bQm2XOYf7cW5ZnuzXShT26CEZ9bDAzv5J2Y50=; b=Rai5WUjsc/9uAJQH
	ZiwWWYiR3pr8L6Ob/rf/wuFjc7mTI5G/NRw83BfjUblgP7MZELvOyEleOcdScftC
	0arFX+FTebf5cNGdNbdUckjUUXGOFFzdhLHAItqVme6dJvB9fTz2cpElFKSaGX2p
	83VJo2ZxlQ2qgmjTkxEe4RIGLbctE1UPCcL9B3xPUiesMoT0WvPb9niPimeV/Ohu
	XgxZi3iBFkrIRkS8+SlGAyMvH6jbk5GAxSlAd8H42FdFSQI8PTJkd7UIQzvLZ/ix
	lHiLmTlwD0iP4ZBO9ioOYJxFIb6mKIpIx8bSuTQl77uD3jR6nwyVrQlz7ed4nXjP
	A474zw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb04us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28bd8b3fa67so13443565ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861463; x=1762466263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgdp88bQm2XOYf7cW5ZnuzXShT26CEZ9bDAzv5J2Y50=;
        b=LCSvjN5lKnupCO2mbGmORC5TSlDwEwlRlyLEd/tMjY1OUmHzODo1XJrbNvx/FuNErU
         ASjJtrq4EwmgVXtjAxtv/BS3A9Nt0rk+3Ypqbt76xivtt+Hl5ES5R3nN9xERFOLtLl/H
         di+W4gQsGhzgrU7fQuWthJAei9aZAnTeX3lgSEXFVZn/lMmouSuAJVV8T0ySQpvdQolM
         ySM1UD8F2VT9byNHsgQsM6sMPFth8AmYTNbr59haaRa37nStKRu0VkdJ1XVfaxEHUe3g
         Bc63wbU0YaTFQm0FSCVoP6kvxDx6FngE+L5689/NCBZjsT9Xw2gvNWeNlkHTU/y0/3uW
         bQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861463; x=1762466263;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgdp88bQm2XOYf7cW5ZnuzXShT26CEZ9bDAzv5J2Y50=;
        b=DuIS0iDrQo/SFJET407NI6l0QZ0SMyBIxvpDJo9fLJdzxEL9P7gC01yXt44eT1oBF3
         enFhWZht4IVBabGITEbHnUGkY7AByxtmXJEm6S4IyADSNJ1uBB7cdzXSuWiC82WYXDhz
         rPsgBWLUg0s6U6DpGLiJAHuaMwsBPp6nwrP0Ac4QBa+7mdfJvQyxT60JT8RCJ5DT6Cru
         sYcpewxTV3B+bTOhU4iZ6Tyc/NZy1Qpb1ZZGbxdhDMEY/hNciTxgm73qOL2pjzepj4lp
         OO++rVyGN61C1rpeT2CeFT+sRUbVu12ti7diAVz6bDQueqwLgkUsG1q2ScbeYfLjbMR3
         cqfA==
X-Gm-Message-State: AOJu0YxyF7V8S1EVIUc1UVGUtl+j3GtTvw2+Dn2KLisEJlzQby5T+DmN
	H9DAMyaVed+Mgspn/xklbqNZGeAGziphJ7JuC/fXYgfL14g2jP8F9EUq9Xe9esjDdp2QjNiTjDZ
	0WdGomqt0/6iV08cVLKtWhZvsUiIqPW/czFNMIQ7lNbsSjHPFdKO2YOwueafQagDjPGJHTg==
X-Gm-Gg: ASbGncuCTW73sBUdHMa5BkICxUsmnC6/b6LdoBTWUOesLQEojCmKnAP9RB+3Xa/FuUi
	48mcK4BXS5MZSClkQaRQ6JYicjf7ts19z8SJWPZ/eitNIO48qYRl/66f8tjfxivW6QvgLrdPjvV
	AQ3CTCgc+mtCkhxqbeYxA0EZleX7GBOeUJsX85D9fxJryVoGt95N/cSW/6wpfwT7BKR5ZG98MJm
	e9+UjuELwiIuPvo6zkU8JjkcyZ8LS6ibWW5NkwKMBIW0EuvHDkvafGoIrjMF2UvPkiRxEybpMi6
	3ByMEHMl9J3+5ERXqYSYOhpBVG7ZzkYkP9lGgquPG4shr8nl6zUOIzaj5kwZntFpZdl9d3q1pc9
	hZha4HVOxqlkT0Q5wGvPe6yPyLrUuSXJYglA=
X-Received: by 2002:a17:903:1b4f:b0:28e:ccd7:dd61 with SMTP id d9443c01a7336-2951a600dbcmr14998715ad.57.1761861462945;
        Thu, 30 Oct 2025 14:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOzoOlAs5uiroESWYyCEyPUV+hEl7UXhaWrI12e2vdeHK3ip+JF/C5aO8Gz/eG2xfF9d8sJg==
X-Received: by 2002:a17:903:1b4f:b0:28e:ccd7:dd61 with SMTP id d9443c01a7336-2951a600dbcmr14998455ad.57.1761861462469;
        Thu, 30 Oct 2025 14:57:42 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
References: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/6] wifi: ath12k: Add support for EHT fixed
 rate
Message-Id: <176186146187.3489476.1922723439873291173.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 7K743pQ4Ro5BOmODX7bj_7oWIKJ084Tt
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6903df57 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=EF6NOILu3u18UkSBF9kA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7K743pQ4Ro5BOmODX7bj_7oWIKJ084Tt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfX3LogND09vdzm
 53Fb2hexbADvuQW3vikAUXLK//nVhUWkAy4KWQd5tzxYHnolPaO6p5cYGcvfvQ6MeRisRCTEc1o
 uykoWleWfGZywyKZuhwloKWkalGvG2hRzRGlsm3rwFzf9aMhydpOWLa1gNpy2q+IGMfVnjrr955
 REzekEdVVXP0Zf/9FelYxz65F0WwQ+htsAkyVcXL+WJsmHGYXydva8k3FCLX93pNKi9BYfszhp9
 n1PbIpnQekbY7/UTGyaLh5uo4WzMudMrg1YxC0xaH9a04vdNbubein5lP7WUha2PeuPH+kRRP0+
 TvQm7PQaGSlIxb5pXMPsYm+xaO28k7k7WMc9zYwF/DSEFbJlNkfuxt69HvdwCO2nSXmwD7Lvmwb
 JvKYeXlG6zoBzWY/8VGdQSdo/q5ktg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300186


On Thu, 23 Oct 2025 17:19:22 -0700, Muna Sinada wrote:
> Add support for setting EHT fixed rate for mcs, nss, GI and LTF.
> 
> Before adding EHT fixed rate support, generalize GI and LTF setting
> functions to allow additional modes besides HE to utilize the
> functions.
> 

Applied, thanks!

[1/6] wifi: ath12k: generalize GI and LTF fixed rate functions
      commit: 770bff79424beec2edb8e7cc63b0e8d1b1a927a3
[2/6] wifi: ath12k: add EHT rate handling to existing set rate functions
      commit: ec1d9b79be5df30f1998f37a49bf14d34ecd6c50
[3/6] wifi: ath12k: Add EHT MCS/NSS rates to Peer Assoc
      commit: 6c95151e2e776462de6b6fd9e577865e8b32203e
[4/6] wifi: ath12k: Add EHT fixed GI/LTF
      commit: ab31a9b73c95ca8a1b527a0d9fd9192a27acb26f
[5/6] wifi: ath12k: add EHT rates to ath12k_mac_op_set_bitrate_mask()
      commit: 5ee9cb2c236b45c4d58d6d464a12d985e453576b
[6/6] wifi: ath12k: Set EHT fixed rates for associated STAs
      commit: 09486128caef9efd88794c8aaa1e9ab16b16f383

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


