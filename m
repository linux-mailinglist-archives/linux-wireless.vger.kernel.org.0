Return-Path: <linux-wireless+bounces-35725-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ee4F0PK82ma7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35725-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B913C4A8392
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3849D302B39A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031A3BC678;
	Thu, 30 Apr 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYdHJ+2g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hyaIlptm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C73B47DA
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584646; cv=none; b=myBO6Y1es7K444z40Osc7da0TDj9rcVnneEkKTEtCznAYflKqiX1HxVFJ4CWPcyeUPR+HvFIQWNxPix8xq3lu0pGym7d2JtkXzXTkwdC5MwTnp9/CBqzvG+hvLRq0Gon34PEZXI5jk6y+56TVkdBZnbSNvjdKrf5OrW+gBW2Pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584646; c=relaxed/simple;
	bh=LXLPx6e3IGMwGwWiuSu4/gkJOJnOybparLY9Vyey75k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dsK2JZt46sqmNz6/HpIki5y39SnPlPU4aq2IigwNsm+sZV4fo7XXwoGyEdc7/i6vMBdaPtqb6KMRfDPt5+YrEUoL/rp3d4tx4TEjd35Pe7/9kzYwwTvkVqD/YEt9qNpwN0/it2ug0B4ZMeZeJR6tUSo/yPVfdncnqOPO0i+CWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYdHJ+2g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hyaIlptm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGImDq2122428
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zcNk7RepMt/ujrNFBx69IMbbsGm9Q1Adr/Bz78TzItI=; b=PYdHJ+2gsMrTzFJz
	xgrHx1h071Un31Stlmm0MrLoOn9L4UjZmODPldQ6g2cL5Vq56mcbsU+OL929FnsW
	xx0ubwfzoLEGy1NvjBlLfdA9RcsZbdYACmFmlMWdTeKEmHQ6Hj3AjVX3gzeKkHKO
	TaDeUgtawC8ekirStawjWMaapgZOucTy4Gy+QOZSL04PkjUauLjvDeFZqQXsxsmn
	UO9fQD/uVHWJHFdrXVW+XGvL1lQHmqeaC7hjLP0im8BIE7oNYFy6FY8woH4fggcu
	lEYb3pYmMFa+aNH5uh3OmWnsHLKBM2PLRNDmAY86vbXgaXx64o+P4YikbzcDrySO
	VMIEkw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4sc4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so1595963eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584643; x=1778189443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcNk7RepMt/ujrNFBx69IMbbsGm9Q1Adr/Bz78TzItI=;
        b=hyaIlptmX7YSP53LY23m2he9SO1EwgOC1NSBcBamvk243iTrGAU4z8J896RDDoxchG
         EpxvfdT2d0Pichas2TGmaeSy6xTWRJJ5Vkq3Th3psSHxFdCjoqCVpCgKbLQARmZIJYDs
         nstgkCW9eYseboXWKMKto7OUN2AxR48zZ5JLrdDMzgwRiEP7hN+t5JtrSQBuYX70jWOp
         yW3IxZNOBoUyWSQxL9FKQ5ZbbXSZNoirtVXpnbOTln52MnLSsy4aOdCTtf6AP7UBY0PQ
         jzaai41RmVEFVw5ZsU/rADAiTIMnqUd/PdxwJ3D7BkSrTq6ZmXTgcKNjMMlTbL7wiRLE
         N1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584643; x=1778189443;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcNk7RepMt/ujrNFBx69IMbbsGm9Q1Adr/Bz78TzItI=;
        b=rDcAIZ6MZyPIVNZ/K24AdfT5y7Ns8L+VH0J9K1pTjvOXuVBCs9YJOkdc3lRBRm20IS
         t1XDBMRiemqlhd/FlSP0qEXO4BtiqAy4OUh/B2qUlGkPp0dhDBJWWaxozq6U8p6wETXC
         sdmDQIYKEbeHsNuADRJvR3LJuwq5LGoW8PJDXXyQNYapESUkDtzgbTOpkKcuc95SUrD1
         IDlPE48zA+PKhygXz6rS1BSb3WDbuU54AhJMd7CCrwEV6zOBmFTWG7jCotiM9w4mBoYm
         GzdmNtnuHMniQNOIbhQBdqMS4euaEQJxaLjMHppm5BipQSWoOwm/be08k4Zgf1NR6qNa
         2RfA==
X-Gm-Message-State: AOJu0Yy50Y/ob8z+pHHFGO+6G1kqVAV3HU2weqjCKFjjQyDedYWPm0Bk
	TZGRQPBdI8Al7nrWMrHF8Z2NHHmUtzvYk5Y/TkiRNacnbDif7t+YFf1hEL2+9WwHUq8H+I2C1nr
	hVj55PqLXQuudLIG6EGSXD+XEAhcn9cEkJp3adJNAYhALlbTuX11iHExaAzwQzQ9B+cVYcA==
X-Gm-Gg: AeBDievs+UH8fJ2fs6nLkBhXroJ1Y2u1hzJ20Hb7IJf+XBtw0keXV7PZ8XudUs07DGW
	sr5CMBN3fK0XCguhwBFlNtC3X4kR0T68fZi4/gugcctU7i73RZVNZK+n83ptk4+ULCYx/6WdRlR
	ImPOhJ8jtX1ZlviKtxkCmog/upy11KCTIqCy52KX6bC2EcbraIcXS+6TscGiI/NtnwR80UtA8W3
	+3jWI4WElSulxqWO7TrA5U8JYbUbNEedkSOdzQfK9SB6evneugVG2J3tzZSpkDMLrTrs1VE3bCo
	+sdzfnhl7EEGuakX5xmNzMS5GU+T1pdu6XUpkE4XaE99TO6iJGFk8xrUlBAcYNxOVqwdPnVFy6C
	/e0K3kfwmRWSgEomG1PD3T+dmsHyEaco/jgSZKb78LQh33gJDmGX/jmW/xY9YnT/cPGQObotTbj
	Ba9s57mmR1A6E=
X-Received: by 2002:a05:7301:3e19:b0:2d4:62f0:b2d4 with SMTP id 5a478bee46e88-2ed3cabac36mr2315487eec.13.1777584643483;
        Thu, 30 Apr 2026 14:30:43 -0700 (PDT)
X-Received: by 2002:a05:7301:3e19:b0:2d4:62f0:b2d4 with SMTP id 5a478bee46e88-2ed3cabac36mr2315475eec.13.1777584642905;
        Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260223224254.27081-1-rosenp@gmail.com>
References: <20260223224254.27081-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: owl: move name into
 owl_nvmem_probe
Message-Id: <177758464176.1848985.2839439458090634520.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: R9ZM_JhUoMQ97lVzHYlWf6eWmHiHr6R4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX+Jho4vQ/7mMM
 eE+tDRVChnlSoG2oZj2Eh414rgBfJSiJy2O47yC1sZXELNr0IAD83Q+sl0a3TuAJZLv/6YXKQHm
 Tm+/Qq+naCoYldKasy2lyDvoiHRkZWlSrpny5Tqd8bNTqWeJEnx5sV+gg9mMaios20g29GKAPrY
 5yBH6PrgXxSXDK4l4T5aAynaA9SOo3AgIPjzbC54fnJdSBDldziL0Pm5m6/pdp8o4rA/SqSMIe4
 U35XwTUfo4ImvLOLfnt4lk12NUqqg/owNSUZY6B5ZVT6APTugLnvx4/9mbSZjQ1oDZNUXALjZe/
 7gFxajdXSY8Z0+CnYfB6gJyguIygiyCCS4Ug7xKMaQyUg4ly1hetMsoOYOH9RITpIjbJdRHpXAY
 Ls8wiamslnTi/ibn3+KZSjugIukc7Nyerhbj+mzHnPagHylnWC+K68bnymiFEK+G5qhpD5zqrBj
 KXZVEAniXHCqVATO7Bw==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3ca04 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=loNhbsbYXzCzQw8Vos0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: R9ZM_JhUoMQ97lVzHYlWf6eWmHiHr6R4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222
X-Rspamd-Queue-Id: B913C4A8392
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35725-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 23 Feb 2026 14:42:54 -0800, Rosen Penev wrote:
> There is no need for dynamic allocation for a simple string.
> request_firmware_nowait copies the string internally anyway.
> 
> The error message on failure is also wrong. It's an allocation failure,
> not a find failure.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: owl: move name into owl_nvmem_probe
      commit: 7b2338d5ec6fee29f92fae791219ab9fbd206567

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


