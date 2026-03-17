Return-Path: <linux-wireless+bounces-33358-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALuiBoG4uWnJMQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33358-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:24:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD892B2372
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA7B314A9EE
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD4386566;
	Tue, 17 Mar 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdJCwjRk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoQryV6f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C528386435
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778744; cv=none; b=i3qcEUzwUnD4jz4nh+kN6GafOkq8ieG6277MtTmKh5UhKsUPIrZTrwRRYHOJrtgLt1XUujLVUZDvMGyBokbFlnNkSfjV17SRL1nKehZDKOZ3AuxmNgsN624T8QtoBnKrGDSScBeBfrA+li5UCVl/0L/TTwwFoh8mDVQqZwOXbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778744; c=relaxed/simple;
	bh=Laf/pfqqVejOKylZn9v1KJeYjvrri+ICvELc5G4vcmY=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=hR/qYbjlBrhGImeetvPbfTlrDC+UB5yJBJuZmNBfRwWu7AAQ+iH9nTOewL8T3g6Brrr4j2VhTb6F8bnuUj+VbYanT96Ig8BOCH3KuFlAHrs8i90dsR8N5c4c7i1vnNQpkMccw0S/+vXt5WrgqkH6zW90QDdyn/mEQ/1HWcgBIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdJCwjRk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoQryV6f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJLFg1370766
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h8hJpBSymWCOuiDE63BWom
	IOUCJqxU/ANvolJAkwQik=; b=EdJCwjRks+tHuwFj0x7YLeaFL6s704BL1NLgXi
	+zK2X75joPTXfmrSjaOwuTBQWpxBlapLQePhZqqRSRQV9olta15fMpxCzmi7s1Bi
	dbGJbbDP2RHQMbgmFRaatm3ruLLoW/Qtsjn7OGSAgKW5AbP++sLyvOfNpQ3jvrQH
	qGwp9s+cv6a62MjGuO/I+hCvY+lDg4pS2NSQR2OSK/OkTO0GuU1Jd+YcIfShqZX5
	t/ZVOr012PQVgQuqFUR+gN7fjdT+mcBAbqTFDWgjUeqI94PPJXcEpOmHRGFRzm7z
	zyfCv3tY/pfncaikXWIQAWWMmQ8NUN6V/d6TMKHmaxAoVI8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he1qjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 20:19:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bea1ffd05bso5876727eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773778741; x=1774383541; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8hJpBSymWCOuiDE63BWomIOUCJqxU/ANvolJAkwQik=;
        b=FoQryV6fQroKkC98sq9hUjVVLCKB0JdHNLV2CWagVHJAbE2omitDIse9/pImeAGjEs
         tO5yBSHskmLcL8nJHrzu7l1349e0BiNVR8yIjiv+14xya//klMVnPrzr275Bhp7ozedl
         yeIJIVn25z5FRzjv0l0+ARaTAdwEzyDru7x+NzkTSD/8H60LW4PbpcLfLx/V0YPIH2RN
         a3HwU79OuhkjbfzPH1WeH2l6yVYxQM/XaAv5FEvtsBPmcG1i/peLqVPWUCCYoTdbVQi7
         M6BQ+w/JVfC3i+MQ2f6iVgUqmKh6AarNdyHb3fp/wlkghZGvPuOd+yieM9Fm8jCyYs/o
         RygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773778741; x=1774383541;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8hJpBSymWCOuiDE63BWomIOUCJqxU/ANvolJAkwQik=;
        b=AMfRO/gUSOYZFszNqNiDOJ1j4RBqOFbgOEWrXcZ2sDM0VVQu2lsZycBhqkFDw+bzxM
         GAV0WJ8Q7oIkoj7rFm3hnmbLioECmW6B6ROnHE58YFW53A4naM+mPx5z2Zs81Aui8aA8
         yV2muW1WNqHMaGvJAFjCLIN/kdAvU044IhpY5EIrBaam/oFJBRZR9lxFZI3JDOpWMdN3
         3lJ9p6CQreo76Tomi6YL4gTA0zG63Fgt8f6pmj0NEQLCVSNp1BIhrGG+jsE55E1RILsZ
         3Pp9/AdIzTUdSG1Xi7WoYIdu6W5Ljen4uoUHkjjgTj9ro+KmmGRQ6dkLWFtNusGBq1x0
         ngIg==
X-Gm-Message-State: AOJu0YwEuk/hBcyBv9QMn8RyUE3SI60vwQXTfEBk3dndQGT53ibVbUnt
	NiCqz7xpQsuLMbjUrPOEKpsiUSyfdjpihf12hPj6IJFpZJwoKAgSHrCEtZzt9XKQbQwAwEzaZK5
	tXjA+6JhMEqGxLZ79KITFAqtVFkNEXpzYzzI7mJWynn7GtIOUGlE9uBCQnTMU6/Om4sdnzg==
X-Gm-Gg: ATEYQzzhijos5nYaJ9YWUkf2dMLqzvjtlp8CnkFTvRAq2Djs9dHaP9KxrU8yVX1xcro
	T3BjFc1qH6bl+A+/WRWNJ/odlOOvTJ6PaqU23GdMMOQtAznWnKSLjz+kWvFkPi/Xt2U8kV4VlCl
	7SPCblTAiShmcuIJ4yPP2JGOZ1n9TvAoxKsSSoJ7M2KTNUcpiQnCxpTQffZNRcLnQQN0lt6Zobf
	EKCOgdVaMQzcqDRVlzJFR/3SroN1LPgWXiyR7t2vIb7qqXEDpkUs+t0aqSkF5GYp6vzTGw8feBj
	svljMi2Nznu8Qd006Zu79q3jdyM4LzRY+KFn3jFVd9ieOmP2+5vD2xijPLRpq8V1rvvr3rukAzd
	53sC5Gdz6sIxXnSJPPbUwhRGtUXYj/iqZLe4Au3bm2OoztPXqfwP9NBH0oQ==
X-Received: by 2002:a05:7300:3724:b0:2be:e4b:60bf with SMTP id 5a478bee46e88-2c0e509772cmr393490eec.10.1773778741088;
        Tue, 17 Mar 2026 13:19:01 -0700 (PDT)
X-Received: by 2002:a05:7300:3724:b0:2be:e4b:60bf with SMTP id 5a478bee46e88-2c0e509772cmr393474eec.10.1773778740510;
        Tue, 17 Mar 2026 13:19:00 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e56062e4sm756534eec.30.2026.03.17.13.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 13:19:00 -0700 (PDT)
Message-ID: <3ff94227-db20-429b-9872-75faf39daec2@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 13:18:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260317
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HTpS3QSCp8IvfU0ldYird_jTr4a7MLuq
X-Proofpoint-ORIG-GUID: HTpS3QSCp8IvfU0ldYird_jTr4a7MLuq
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b9b736 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=lm4jLvrnElEPTkshbfUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3OSBTYWx0ZWRfX/7fyvFaRDyS7
 cx/dFgieCjr9MH6+ey0D8fCFPkifc2bmHlVZkg24nWUYLMtZwXmUG5bVmXRjqeWvjV2kbGvB9py
 Mp4yd2FcSXMjYteasbPEYpTGhnvymbMZLPpLXa4dOPl9vR3n1l+nHgKK4h7xpOn39zaDclQIS1E
 xS9NR8Hzy2hSii0DCCmas8czoR+2cCiIM21L95udHfkiqXeQfHYB7BJahAbnwEqfxhneEJEElxz
 5/Jh95be5obQbYEj4GdNOXnWUHi4eW1DwZyytQITrjokQi5gn0QnjjaeHx2ySKwsUFv7uprNm1W
 pcCcKZ5jDmAmgPIJW1UKNt8G9mWiBsLO285IAkWuyKgWd4skEuENHehSFbprsD4FJkYVt7Qyat/
 j+2DWTgRxd/VxgTAkhezecObHIRQ27TRU9jQUuhm675FEktKUaFQxO8a7qIG7HknR8XYt8BInyq
 glqeQWsYtYp+FzXDflA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170179
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33358-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7DD892B2372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 81f761d1b5fd51469d87d1633a959dbff4785f58:

  Merge branch 'mt792x-bt' into 'main' (2026-03-17 17:33:37 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260317

for you to fetch changes up to 6fb33265936075ee1bb5a31786a4fe1b30fdd001:

  ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3 (2026-03-17 13:07:48 -0700)

----------------------------------------------------------------
Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

No updates for ath10k or ath11k

For ath12k:
Update WCN7850 firmware a new unified firmware supporting Mobile, IoT,
and Automotive.

Please let me know if there are any problems.

Thanks,
/jeff

----------------------------------------------------------------
Jeff Johnson (1):
      ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3

 WHENCE                        |   2 +-
 ath12k/WCN7850/hw2.0/amss.bin | Bin 6082624 -> 6090816 bytes
 ath12k/WCN7850/hw2.0/m3.bin   | Bin 299660 -> 299660 bytes
 3 files changed, 1 insertion(+), 1 deletion(-)

