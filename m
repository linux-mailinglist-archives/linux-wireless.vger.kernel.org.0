Return-Path: <linux-wireless+bounces-37457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Sm5NuBCJGpg4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0D64DDEF
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SQL6hcWS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=d2ZYhJj8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37457-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37457-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 331EB302B265
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D83B7B91;
	Sat,  6 Jun 2026 15:54:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EF3B4EBC
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761255; cv=none; b=JBWvDBG2JuBFgbG1kFGVaTx6mGGVUI/ZLb3E632EXheWNwZeWJE/q8NL+C4mMlJkATZobWMoFb6rtBEZvYgf+fEePzQMSZerxWkYHpBnZpKvgLFGCD/3HOt7J+aKlen2uklUOthz43UkHrd/1bVsHY5W0p1VTEsEthhcVh6V91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761255; c=relaxed/simple;
	bh=7VIskF+YryG4T/BRMvtVTn6C+/gzNt7MW3Nq7xmAkkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RdL0WQ2DQcF/7B3g28vid0aEu+AGTlCdc2nmRyOreVLDeDTSmqbHAyzApkI4eWTriqgNOMzaeIoocKa1TsSkenNTNqGflod7K+0hbw8fDxZLOKabF2E2wgTBeIl3/AiR7TFtnJ/8d50fmEx5/VxCKT8ttS8QNOW+Se3cDrqCcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQL6hcWS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d2ZYhJj8; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EwPGR2223913
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oPqNL2iexZHKlubxENPVahvJw/ppvuwjfWmvOPoioIc=; b=SQL6hcWSeiaTCNyk
	tTSBf7DCWzIoqZyY7V20imORjPu2Aj80m8H98EzOlKNt/ZMJpkVsG35RiFZ3fdiq
	QNAG54vhZjlYTfFOABP6nc+ps077GdtKN5HzpfC2boxaO3i1xF3pOq51+GY4Z3w0
	Mtbgh40hjncwO2H1X0/GTHrsTMcE9kcZvfuK7jXF8JAuGXPYGngsxhrHYdlui1LG
	gdpG/+LjTESxorPNetIr0VdeqcHVzfKT0hdTRtf75314sx14F508d4c+4lwNg+f7
	9gs0IeJZUn/MAzv/amQGNpAH7KNZawPwd2Nt7eqfZKBhFTPh4Qsj9o913B45+BLv
	PFWb9Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4sv1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304e4636205so6288345eec.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761252; x=1781366052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPqNL2iexZHKlubxENPVahvJw/ppvuwjfWmvOPoioIc=;
        b=d2ZYhJj89IaHwsxgUXw4k53Yt9aDSMtnhSA3effwcOO/zBvYRr9tUUtfKvt5VAVi+c
         dFLftqI/uy6BsRDcfiz4hINrcmYrmzUs/YGlOca32O7jfu/Suc0A6rORhNN2ok+iiC2O
         21PTLp34j3C2mKRPD4UK0jRujyGqF910mEFNeFnTsFLQ6ehY0dd7I8nz2Ub4x1zIba5B
         WoC5IbxFcJUrfuRrz7EdXF5+Pdre2d54gv/2pRl3O8BWoLHmLxKzhBC4d3eDvwfbJSrq
         Bikuf8zaWTfcB31I1xHSnihBbgyzpVlRYgpnxYDah6P2TYRU78ovKcdZ47IUJ8zkKZrb
         9Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761252; x=1781366052;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPqNL2iexZHKlubxENPVahvJw/ppvuwjfWmvOPoioIc=;
        b=epC5n5JldeqJ/nakn25viFSUQqpsZ4rKilDZ1TzgJYmrgQkl+ipzop6jCc8zZG0XnT
         UTtdSprB/bpjaJA/uVRNB8R8H6mXDhxh7ui6bG4lglA6sDyDzfSsSsI+3THNZ8NpsnSW
         hyR+5rZY/Aw+ZONaG+v+OzIg/2PLctqRNczMis44BwcMgtZczCtki050Xc2yqoYDNIv6
         j+wYsR1WV2dVBMWsZuannu9Ir3FLEl+zAwk4QrcADGoHYk4JCNCtw6NHJHwSXY4J0qfr
         T9litH1xqjmALIr7QNIaxqa5UN1ZPxw0UazD0YejtqbM4ZTRNJVidaT3bY9mOZlqhOOQ
         PbXw==
X-Gm-Message-State: AOJu0YxKo5iwnmmPA3AKL8T+Z/MQvPb/G5E1ZC2DMI3xkPDQTC/U2hh3
	0jrZE6aipxiRcfBIkjZHeRF6qrs9ep+Ibd4lfmeHVhQgscfYTdaJjrfFF9Tutbai0zH9MOPzZ2B
	IGD4JYsDlwg9hoCUr2g5hrOrChiTPeZAnqzpCJk3aWWo7r3+ylfnpsPB8XMuGMo1KKot0Klf3C+
	MW5w==
X-Gm-Gg: Acq92OHUq3r2EAtlSeFaNvavvPdncolCWC/ZS6dmUGKggiH6v/0YWKuLT6PqvmJao+Q
	C83NYHRrkSsH2tjHCnfLjJk6ixfgiNlIxgM9T+L67nNUDapOSlr2baMcnapRacQhgsg6Skd73jf
	WNuqb8S/YzYIBjTDzsQaB5m9OSVrOt3+pd9nT2kti/2EymlIiU6w/aPGqyzpP+nPILlPn8cemlm
	vf3g5dTcq2lf3C1+Ew4aKNMqrlkSxToiNTY8CJG5lWNf+m2u1vdT7ViA2mzMezz1Sze9KhNfIzd
	T2iSOYEwjOqHDfmK0bAMnVUIG4T+J78evQP4b2WGeko+EuDfaJcNB8jWbDI9ZE3tLJvXWeZhL7p
	1haEAWBfIfGnTxRxRUpvJ0xT04ubQ/CYeMNdxn9stTOuI7/MYWjwAFfsY8ZWKsVF3BsLgHRNyKn
	R3U6kdUgZpmdo=
X-Received: by 2002:a05:7301:9e41:b0:304:d456:fca4 with SMTP id 5a478bee46e88-3077b1de05cmr4690923eec.21.1780761252170;
        Sat, 06 Jun 2026 08:54:12 -0700 (PDT)
X-Received: by 2002:a05:7301:9e41:b0:304:d456:fca4 with SMTP id 5a478bee46e88-3077b1de05cmr4690914eec.21.1780761251670;
        Sat, 06 Jun 2026 08:54:11 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:11 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260521232020.261405-1-rosenp@gmail.com>
References: <20260521232020.261405-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k_htc: allocate tx_buf and buf
 together
Message-Id: <178076125102.768205.17591308200046807643.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Of5jf5txbytJLtJBInHDexTXUSzGFLZN
X-Proofpoint-GUID: Of5jf5txbytJLtJBInHDexTXUSzGFLZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfX1DVemAZCK2Qn
 CZUyeyp9aqfX/IiiTLVm1Qy9NjrILFKYwFUxFyjvkpWT3HVVn677QGQ/l9ghS80Ce8ON/vSLojR
 8B/OYtwuyWiRoHZtMIFUD9grnGBOM6C389FlBSr63qRnOX7XPlx0bAf3tMDHgVmnGsVmO6QvTWy
 rdR1O0l2pIOLTEjiBv3JH1u7gV1UYzE2ohPN5NdAFH4QjYYDYLfeJ8PS0EgK0FYVboLygPbbT5E
 nTp4TuSsoIiuBNXSLJNlMMBQLgSa743emw9C00jvmrX3Ct0YUBfh055AxucpT9fkyWeinFCUpSj
 9NFefBsp/7JzUx/kaBRQI4dihWF6ZuE28c9RStlfs9LmSoM/1R+GCnWeovMtlHkXOnTILSxNMp1
 d+xjwWputY0Z6VvjPtb8T9zqdpwPvFcA2d1loktv0SW4pmXuwtmtv2m1mV+Q/+mtcyjrVVXd/vE
 rMNS7xG/1G/mtFWBTbg==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a2442a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=GByQ2BQdjjyrgBjb5IkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37457-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AF0D64DDEF


On Thu, 21 May 2026 16:20:20 -0700, Rosen Penev wrote:
> Use a flexible array member to combine allocations. No need to have them
> separate as they are always together.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k_htc: allocate tx_buf and buf together
      commit: 38b2fb7d2df16f5801f7d88a4739942b95a5f6aa

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


