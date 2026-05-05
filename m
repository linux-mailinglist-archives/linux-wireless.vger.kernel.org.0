Return-Path: <linux-wireless+bounces-35910-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB5iO6/4+WmNFgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35910-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:03:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B54CF01A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 956383056606
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D22459CF;
	Tue,  5 May 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCQc0WFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A8fGnKlY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE4272803
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989756; cv=none; b=GNKRfE7Nei9Rg7QbZaXtt/HFS+tXw83D6E8gvMsnlDtY5ApaoOO6AB2++EVvmBWuIuImrGHhMorsFxvxd8TPEFO/cID95wkj2+8ZCITXEIs8ObMFcLo9XFvqYdZIDMgSVx36ICQVc4ffnkhvaG+iB02+fgA1lBM4igRAFD66DBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989756; c=relaxed/simple;
	bh=2Z2m3L/RcpFFzH6/UCgTTIagtOYXBCp9UeQWCyVfwKM=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=B86hxcQodHnWcJPR/O0+MkG9zaZe8dmO6g5hUrmhOlv98u5MHOg8qzVUy0M+2Xpye+iORmaY2qFOiEQpaw0kWI+1wUeV12l7aeU4kf9AMHF1JjjiWLkrBvq3xZK3xBtr99cFrsNFixHvlKjaX+GVtlLplnKgb35hu75XwGTDFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCQc0WFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A8fGnKlY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6459VU5e2859242
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 14:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NX2GqVOMLwVw8Cryw7SY8Q
	QJe69k3Ra4iwriZpqn3SU=; b=CCQc0WFp7xQXWugeo64R2XJr94jSLF1YAvgDNm
	yTRys/qkD3xKviO47iGpe2h4ekOkNlhwkozr4XcFTCGIanp3x+YegqC5PUsiXYJO
	NrEnl+cRRfxC9r7XR0gEk7fWMVB68/3p1tT6/hUms0rZgcwdFM8dGC8abZQfSe4z
	pC63Pmp5olLFX9Lrn9Bx3EHu92osJhnESfUPZkSgLlfcW5xgc/3eDe0MHfVM3e2C
	uVT/iBPaKSzBa96EaVmavR1gRB5HdbkO9gEgrSjavO/+Ra1pJ0lovNsIXug3/uay
	CFBUJrsXvQT1dFW1agxe1G2PirwBepIT4ElliPmMWTeuJ+PQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0ah2tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 14:02:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-130aab787bcso3252187c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777989753; x=1778594553; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX2GqVOMLwVw8Cryw7SY8QQJe69k3Ra4iwriZpqn3SU=;
        b=A8fGnKlYA3zboZ+ssMsoH37J4w1++/DEten/7RDDx8oPCU1nEJq/cEm57MLkY/ZlRv
         /s1C0ONM7A0B6Qbt4nAl+NREhn2JNw7GVX43jTkNAsaBdRHvDQl+cSIo2qOZXYEuIC6Y
         Pz7C9tfAKKBxTwQn3zi15nVbFst/NS2cyZJjK2TCjlrizbA+DH6tg8DJxT4jjIa1KKB+
         mQvM6Dtw5SMJS9rJIjg4Oy6OEU4PUkf0CynLI7ogMvRIsU0nZ43TYa2EHWxoc0fjShkO
         iBsgPGy7HmcrhoOBd0mv2wbOa2viRnTBLhMJkuHdqtEq/acgXfTKuR0OdzI3uu+zjo9K
         CtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989753; x=1778594553;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NX2GqVOMLwVw8Cryw7SY8QQJe69k3Ra4iwriZpqn3SU=;
        b=lyVFo4XPXhFkeUH+DygU8ufNbqkAOlkPjUEd/KpK74bM6LB7PSwex3MXrZQxx5/MkT
         OKDspL3pH8yAe3+kNKlDV3BsP8AhjNM7N87Xhb514M6dUteBDRi8klUs5H3SOhciXHdq
         x6J4tefZFTRIPHplGCWc3mhHEjf8rpJ2t3dCWhYoypwG0HW99zTzpExPTRU5AR9UPgsy
         gh6HkTm8hJtJVk4ZcBYVgs8dLk2l+vwjniu+ZZJWwZ9o/m1RFh812rt019pSPyDHu0gS
         McrWTqH05wyrdgrNHbXBha7ugN4lyWonCC1zZ7eLfoOTX+X+Xs+tkinHIlc1JW4lmVw8
         M+MA==
X-Gm-Message-State: AOJu0Yx4dOK98pk6sRmu/Tdzlm4guFZySuI5cXskEL/WZJd8uMucsrqi
	wJJ64a+cxcXrS/lRWa13Mg7dCyzW5wkkxd/knKbCz/wrdDKApB7PMsOz1+nc+5ZSTl6ycBP1EuB
	oo2QlSTJc+B5C+LZzdj7rv9ho+gWD9LsE6gzjBgBaopo2DVd4KUssUg16m1WUdgZYT29R1hWbtx
	8n+Q==
X-Gm-Gg: AeBDietHXc9Kh5KCMUmtCkAsqGfMTWEQ1i+0X5sl0O5U6esoV6/mzZu7Oa/Z05n0XJK
	92soeTnlzqI3DUWzC69V0CiHdMggq63seCHTQh/mxPtck7C66EHuBKaPgdbT7AqrVh//cAgncNM
	rGGWTB97TuWxHl08cpFmNMe5yLsyPAszpeTLVQKRSpk2/DzWmMmdT3jZzg0dM3wu4jQKZFdbZ1k
	96dNGcrSrAS4/n7+yLNCf0iBcrV37dr3FSoR3YHD2qi50wkjYuaHcsNzuq3Urj+4J06EyuL0oTA
	2jglX1FBKbYxnAJI1C6ZrXQsdDMlwF2Hk8H+2MpUaQaDWBZRuYHAjDo4AcLj2gWbQBIItdHA8E6
	zI03cj+AtGGWaOeT1YvToTuJY6kXA0LiFYANltJez4h8krXft6Sq2ypRnCNtwS8Y0yxgV
X-Received: by 2002:a05:7022:660c:b0:12a:6ab7:3f73 with SMTP id a92af1059eb24-12dfd6ef2ecmr7329902c88.0.1777989751674;
        Tue, 05 May 2026 07:02:31 -0700 (PDT)
X-Received: by 2002:a05:7022:660c:b0:12a:6ab7:3f73 with SMTP id a92af1059eb24-12dfd6ef2ecmr7329781c88.0.1777989750591;
        Tue, 05 May 2026 07:02:30 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df843f04esm17828716c88.13.2026.05.05.07.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:02:30 -0700 (PDT)
Message-ID: <1078e0dd-4d30-4cc1-8ca8-426099127efb@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:02:29 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260505
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEzNCBTYWx0ZWRfX/+sH2lgg0Kb8
 /U72IuNhwBZlfdvGmYYY+rkA8NLaEt6e53AYW/viSX2ucQoktI1t0PSBvxWxnoHA9n4uZhXOweg
 Fzcjjc0Gmt8h4hWdX0nyfsdDeMoQJAkn1itp29lJfhLq//wHNx/ULPLECn3Nt4sEmnxnp0hCqrh
 xTOiJdcWNP0oImPAT+JI4xvd/tnAkiFWxhgus5PAc31acJi90IQscSrvvnr4OOqdDpjxMalJCNh
 os9jW7luxKHDVuw6eVNos7fgsSo2r5MU4nDhQ7sVuY6PV1ZtmMcW44u+SUuciOS/ctFnw+H0vgV
 TaIb0NkKPdDrYXxrLWZpioDdc8v9okbh0mjyirShpY+RGS6vVOIjJ9+rdbT8Yo0myIqEy+txhv3
 gydsi8ZM9W5b/p0hu8AIf3FjBrqa/TKxPaDzlzeXTtNuTtK+aiz9CwfwxliCLKySANEIunDscZo
 z48lqvB3UO6MOXffiDw==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69f9f87a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=gN_giuKsPDD6efEbj5cA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: pYIKMQk4hhYOg5iIEMKG2riyLp7DBG7B
X-Proofpoint-ORIG-GUID: pYIKMQk4hhYOg5iIEMKG2riyLp7DBG7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050134
X-Rspamd-Queue-Id: DF0B54CF01A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35910-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The following changes since commit d997c32157d2ca06e9f3f00ba6c4bf06593b49e7:

  Merge tag 'ath-current-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2026-04-28 10:41:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260505

for you to fetch changes up to d748603f12baff112caa3ab7d39f50100f010dbd:

  wifi: ath5k: do not access array OOB (2026-05-04 07:15:20 -0700)

----------------------------------------------------------------
ath.git update for v7.1-rc3

Fix an ath5k potential stack buffer overwrite.
Fix several issues in ath12k:
- WMI buffer leaks on error conditions
- use of uninitialized stack data when processing RSSI events
- incorrect logic for determining the peer ID in the RX path

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: fix peer_id usage in normal RX path

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Nicolas Escande (1):
      wifi: ath12k: fix leak in some ath12k_wmi_xxx() functions

Rameshkumar Sundaram (1):
      wifi: ath12k: initialize RSSI dBm conversion event state

 drivers/net/wireless/ath/ath12k/dp_rx.c |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c   | 105 +++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath5k/base.c   |   3 +-
 3 files changed, 92 insertions(+), 18 deletions(-)

