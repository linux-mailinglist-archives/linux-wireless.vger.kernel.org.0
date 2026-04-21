Return-Path: <linux-wireless+bounces-35177-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE45GRCN52m89wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35177-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:43:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5943C38E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B2B30B123A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263C1A6828;
	Tue, 21 Apr 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iy++ZPrI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlAfJ4Kh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75013387590
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782174; cv=none; b=urG8xHNjfcBiKsFrkzYu0X7RTdAcVYPLZLj1xL+jUJzqmiBX+UfMUllKjyrsNmY/XIi550gJjSDA2SecG/8jf9NBu9Ie9dFf8IawuRWFcUliUOMRICUTzyuOH5nKCkv0Q5UpxauI02etVeYo8KDHwci8C25sLCAvC+f1dIgvFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782174; c=relaxed/simple;
	bh=UIW2Xgv2KkP5hyymuFhqOWY7qKk0GGTsgB4siOKyAHE=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=f9NdIUk9y3qA/3Rr/9tCn503O94p8nPzPjkdONcrlu0rV17Wbhaad/wiMF8RHGdrwM/ZWKO8GCrtDxyQhGvx0ZFTa6RwIuFHL/80S3lafSGXgL7gadjGiBFJryfCF1LGtpynx4lIV1kf6QMateHoSyx+kK2rRjnS7tlYpgWWsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iy++ZPrI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlAfJ4Kh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBkb2E1014378
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DWPUc7al7seOtzF17+ZKNA
	mhSS/cjwEU4vt4ddqzkso=; b=iy++ZPrIOWmSzp9tyjXuKOP9e9KyDuuQpabMo1
	faj2cCewDGJeXhJ1+d5zhIyQw++CZDzl7A0VX6o8zpbw6pbjAD1o2BoCN2NxrGMJ
	37GvrFTiVLJeBjujIlT4UFCXgbc8vBbM5Ogp9muEds/6z4BtvfKJ3XSnPtgbWu6A
	LGzzFlfMW2uPHMbo+PWFqnYPejNTyDbgL2pz88GrOGmIuVKFdG9kjzXYFslQ4bXl
	w7VzJsczcpj0RLYIs2BG3AQXdfMMkPg8KiidoCNTUngOpFaQSma6I2JiYfGTsGzO
	aL8turnswMAap/7zX8qHTzT7qlbDPcLm2cFoKRH9TcNGJGVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnt903kd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:36:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso4490497eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776782171; x=1777386971; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWPUc7al7seOtzF17+ZKNAmhSS/cjwEU4vt4ddqzkso=;
        b=PlAfJ4KhjEmiTlc1cwgamBxebrDZDNT8SAtn7PaURHij9qS/Q6rYojfP3oK3WemiI/
         zhyKKf1NGaEkSd6bdDhnn8FHGyboQ/zQe9Yz8Ktan8tDbTUTklRpbzGqNnIdaligPiNb
         eXR/fcatGHU3u7cvX9qo6ILBCyqJ1G7PcXoUvhpxDz1V7zUAfzaSFkbq8CZiTu5attNB
         LNh30ReWLXnkLakrj0/D3dTVGKXgKe+6GZ2/EqYZVG2dTCPecNvMPXICL5Owyx0AApYe
         TzsWaxw4WwlNqOWMxTZRqqnje5hgfYBit/NET09h9zEmkqBPXbKEUYmLazsakoIn7Qqd
         ad9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782171; x=1777386971;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWPUc7al7seOtzF17+ZKNAmhSS/cjwEU4vt4ddqzkso=;
        b=I6rWfQ8gVLD9akznLSNBhyDueWQc1Ux3Kdftx+WhKWI05jJcqnu0OAkQZxlOUoIuv/
         9ynM4GWyuweE5ZIYpeQavrcEZ/3VRfWvc4yyP/D7ueXMxgdjRd5qndmVbuxgYDXB2kWw
         Z3MjEdsePNZybQBbNNHmeUmUjPEl9CtoE2FWyLgjbf+X0SAn53ugKuuwe2L936KtSDpB
         a1hjF3LNfbiwDeMglq5SZywZKXNM0saTBxiNLn38XN2kMcN7RtxgdgLKNfPfScllZXQh
         BSq0va8clHm/hKZ6qsF3wcK1/hpn83rGGWGuZxNLrYdlLk6DLUqLunJu5JT2TE/zNNUQ
         0l1A==
X-Gm-Message-State: AOJu0Yy7W9/jDytCxK+oDWrMV09YWZBbaNwQk48FzzSRO41jQhRlfbnk
	0eMtBVVHNkRoQDEB5IAJZUrhRh6mpt6kaycDOWdUzY66paugThYf5P6TYhvchM09aLCyAInXpDI
	gcj3nnaloKY4Yz2ts1JMjyHowCLFzlZcWR/EnnBGyRVNByoFH2cTZG2j1Nevk0OI24GC6YbTzWd
	8XEw==
X-Gm-Gg: AeBDieuEy1NbhKTKJbjt8WQxfFH21pMR3ht+Sd46q/bvKIolQ/1J7pppojaW6vqbyzA
	AHR3W4h0Kp0Bt2Q1+4vAXWFXWWdHUyViePwql1f8jFFZBnyfHSqXeMoJfKPeMg3xpUllUpLoAyE
	iyywnsiwhaC+G/oS9FOiwgEaGmW6ZP6PA6dy32NVZN9zKUe3MkHzwWZ79rgH09Mbf9qf1SxPmh0
	CBZZ8b78+1/LVTn0dsDtoU7VqSiGB3pin1TZTs0qzCnqciS59Jw3Yjve/LSRfOQ753ByBw003XJ
	Yuvh2IOzbQ5yPscXqquhupmTYp9G63aGMBCuzy4jecWrSnVTLpGNhENKc8gBEJTXDbNGUkpufQG
	3q19de914ppLD36zmDreWtemJtgBvX4wqAloVOtkeTzayE8D06R/VhgD/wvw+1m5OBU2y
X-Received: by 2002:a05:7301:4704:b0:2e6:e77d:7bcf with SMTP id 5a478bee46e88-2e6e77d7e0fmr4635756eec.22.1776782171425;
        Tue, 21 Apr 2026 07:36:11 -0700 (PDT)
X-Received: by 2002:a05:7301:4704:b0:2e6:e77d:7bcf with SMTP id 5a478bee46e88-2e6e77d7e0fmr4635728eec.22.1776782170740;
        Tue, 21 Apr 2026 07:36:10 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm28627176c88.10.2026.04.21.07.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:36:10 -0700 (PDT)
Message-ID: <b581cc04-f5cd-4e99-9251-523e50623b03@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 07:36:08 -0700
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
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260421
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KfbidwYD c=1 sm=1 tr=0 ts=69e78b5c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=Ulex03xzRqfrDqNhIRAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ztrhvxIKei5WSCDXYTbmwfA2HzwNvZ0E
X-Proofpoint-GUID: ztrhvxIKei5WSCDXYTbmwfA2HzwNvZ0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0NSBTYWx0ZWRfX+RG4ZPW+lH7K
 CtEuU5ysIbtEoH/pmjnHMAoxFSWXxzo/lXsB3Of2PCHlQWorNOlkEQ0jVa2LxUzLgZri3d3VLyX
 bacwOz7FtHBVzpHjx+yVdNGHjyiAWtpXQzyU/9WCrXWcJyGW9Q4sPoy4+UQ+pwHoqIKHq9xwVtK
 kvWDAdkt/J9Vpj+HLd6RAvG9YbVWCk4Fvc4SfIuMtdjjDngVl4wEnw9Tsb4+c9N0uiwF8PVlZoy
 tmM53QCQNzluml3I7wA6R/SuP3t1ls8q8V6fphp1zIyBcTFZzRo1sqpAg3DbTLE3tcNLPAP+lEN
 gbQ96xlpmzKA/2mHTVTEXbFxJlTeyi44VmgWnCNbcisZ3EHk00RiXyeBZj+c/CLLJUMGrrHlNez
 6zQ1FMFnceXgHnqCBF7UiUQEIoS0xzrAuOHduipMVWk3giebjdrh6z/32iWG3IpJCtHdI/m8U7A
 G9z9zN4s6d15/4ArelQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210145
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35177-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BAF5943C38E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
Here's a new pull request for ath10k, ath11k and ath12k firmware.

There are no changes for ath10k or ath11k.
For ath12k, add the initial firmware and board files for IPQ5424 and QCC2072.

Please let me know if there are any problems.

Thanks,
/jeff
---

The following changes since commit 3fc7117bb925983bc39d7ba957ce5fafe1f65d41:

  Merge branch 'wcn6855' into 'main' (2026-04-17 13:57:51 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260421

for you to fetch changes up to 5bd6cbb6ae899e81c1ac3f6915af05e26a354b51:

  ath12k: QCC2072 hw1.0: add to WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1 (2026-04-21 07:06:36 -0700)

----------------------------------------------------------------
Jeff Johnson (4):
      ath12k: IPQ5424 hw1.0: add board-2.bin
      ath12k: IPQ5424 hw1.0: add to WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
      ath12k: QCC2072 hw1.0: add board-2.bin
      ath12k: QCC2072 hw1.0: add to WLAN.COL.1.0.c2-00074-QCACOLSWPL_V1_TO_SILICONZ-1

 WHENCE                               |   11 +
 ath12k/IPQ5424/hw1.0/Notice.txt      | 3987 ++++++++++++++++++++++++++++++++++
 ath12k/IPQ5424/hw1.0/board-2.bin     |  Bin 0 -> 353740 bytes
 ath12k/IPQ5424/hw1.0/iu_fw.mbn       |  Bin 0 -> 348152 bytes
 ath12k/IPQ5424/hw1.0/q6_fw0.mbn      |  Bin 0 -> 878224 bytes
 ath12k/IPQ5424/hw1.0/q6_fw1.mbn      |  Bin 0 -> 5623872 bytes
 ath12k/IPQ5424/hw1.0/qdsp6sw_dtb.mbn |  Bin 0 -> 20404 bytes
 ath12k/QCC2072/hw1.0/Notice.txt      | 3386 +++++++++++++++++++++++++++++
 ath12k/QCC2072/hw1.0/board-2.bin     |  Bin 0 -> 401232 bytes
 ath12k/QCC2072/hw1.0/firmware-2.bin  |  Bin 0 -> 7111860 bytes
 10 files changed, 7384 insertions(+)
 create mode 100644 ath12k/IPQ5424/hw1.0/Notice.txt
 create mode 100644 ath12k/IPQ5424/hw1.0/board-2.bin
 create mode 100644 ath12k/IPQ5424/hw1.0/iu_fw.mbn
 create mode 100644 ath12k/IPQ5424/hw1.0/q6_fw0.mbn
 create mode 100644 ath12k/IPQ5424/hw1.0/q6_fw1.mbn
 create mode 100644 ath12k/IPQ5424/hw1.0/qdsp6sw_dtb.mbn
 create mode 100644 ath12k/QCC2072/hw1.0/Notice.txt
 create mode 100644 ath12k/QCC2072/hw1.0/board-2.bin
 create mode 100644 ath12k/QCC2072/hw1.0/firmware-2.bin

