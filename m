Return-Path: <linux-wireless+bounces-31742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A6nNl/BjGkmswAAu9opvQ
	(envelope-from <linux-wireless+bounces-31742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 18:50:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EE126B76
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E048D300F530
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6E255F5E;
	Wed, 11 Feb 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjqUI9ap";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5895E4G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674C21256C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832220; cv=none; b=Zh/EQ6qUMNBdiIa1FiU2lfzS6PtWjPs8OHJZBpyIjUNe6HQKIIZJsjbu/LzrB6NSaRBK0jWV+Jn6N7/tGHJ3ewGybfI32HakWszllxkbOJOdl53QG5W1Uayv1sKejc9nXSl7SmQqgxd01rlgK9llUlxIAKPwvTy6GIEyM4Gluh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832220; c=relaxed/simple;
	bh=eAudh6PK+dLgOC5j0MLzI+LtO8w+OUDxJHHfroUqwCE=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=ke7gnN6dbjhMGp3j6W2hcYN4HWf2OrJS0OrKV6gSS+8ni7vcjwq3nF70XQlMds4W2InJGAuOhheoZpKq77qBD+UePkHMvbHv18lE7DD6jnewC2XeG41UdQeBsJZ9MRVUBKUSmDfYayQI7HAG5v08ixswhUk888U0LCiXgGOb2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjqUI9ap; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5895E4G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGVSDD1951617
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 17:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YbEKtqACNKXR3HnZo2sx2b
	ZC79gvHeWfRD0XRdypxok=; b=cjqUI9apyQoddM8cKej2SKUvwO+LCrfEb4sppO
	RXk7PTK0uFBKBRgpoK5lTBjlurtFJpHqLwWXtkFMkoWiCbuYhEI2Rec+vsZ+ZbBB
	HShNKuKEoM++1JvJfYcZVixp97PrzpdaJyXHpW04OxBhQE2w5ifN5vwnKbM3lBP5
	HRysqNuLJhPAogGTS28Wr4EFsPtQUhv0M0j0KARUNP/iLBB0jjZprXrJmAkHE8BX
	1f06eIcCyhcDt9sn2jRuasCnNL1DUO1wp+iMJHO0D+M9iatbEUAWnY9PLRhggjSu
	oZsfu2kVHTINxX3wYTDP9jJDqvXn+Zk4IfKxKFUQycP+uCNA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8wc4r82e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 17:50:18 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12711ec96fbso22376172c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770832218; x=1771437018; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbEKtqACNKXR3HnZo2sx2bZC79gvHeWfRD0XRdypxok=;
        b=I5895E4GDXE5kT3r7p6ZwCqmucw+0OtVV2nv5Mp8Ap4eUyoAb09gEAWd0gkSzkRMOL
         z32T4CVtrFGW8oQoyvNteGRcqt0k09drG35d2xj99fDpRxDmob6aziBqR8mYvURjSoDX
         CYH9Z1+bt8D9bXbRWsXdTSOIRaDkO4NGvRMIMn3eKFoyQdqCUx2P3350afaJdNP/Z459
         Eg8hKKqqGYyWAXOUWYqhLQs4sfb0ccgMJPj7pPoDpM2XGaerCC8jIdDUCk8RV120RTZo
         qoE0s0wUxEgZNRK+3IU3EJOL4PwPll2jp26/Tn2WYFDXGtPMXoj4PC/y5pQrGeQzJlEt
         Izgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832218; x=1771437018;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbEKtqACNKXR3HnZo2sx2bZC79gvHeWfRD0XRdypxok=;
        b=pXuahub9LsvA98Ifjv58FMZCZ6g2eTSnRRaJ3RaQWhrHOl8EqXwSX+h9UAbWMeLTmG
         XpZcV1+vvGTC/mbdhhKLtX4ajOeOAcjTVYKIBD2BIhcuRBqNn8oTQ8Ax28vIxPmzpuB+
         RibzYFmfMSMpJbMeb5UCi0marclnJz6PB9FQlZz+ZUM13lU2W0u+AJkzOEsCEe4eSGXv
         FloAjMEZUSOrFuZsZ6aXIB21XBYB4zqr6oBx22hfydzO/U+KA79otf/S6yYFsZ3KqlW9
         orsPI2QdPSwF9SnGwQoqSKjvGGZuFX3ELrxd3We0eUfn/BxT8svlHlh22PVxmt0wd2RW
         X5ow==
X-Gm-Message-State: AOJu0YyVMbK2zQmsUhbqM54ezvWTqMPiYy15OvsXhGngp3tLCZrAk+Jb
	u/eYlEtELiHp9wgGvBjlovMwPIj2ec+QEjWJmJhqFezBvXE0Nb2aS4J13neGMozt4PfYu/avK/u
	Gr1AfPGsIcqvCrBjPEN1nQHNJIWBBayc0YlDM+gUXuA2ckJgnqXoCbDi7AQnBg/wWBHi+tQ==
X-Gm-Gg: AZuq6aJ1bxcUCWzwg9AYuqBfVAJo84xmKVOz/0k5a+91QY6iTz+6+yv3NkooxGkL5QH
	NnqDPQyLbw58JYToVXQBBx9RuXdIk5IkEqivCw+ZSXdo+0rkJT1LZ/QRJScXCTworQMVMaPaLAv
	JOc8M7b7/2mCojBPuxngme76VMDj2OXXvEcDIs0yVwn4iKwvpzCLhWptsEKetHUR9OocG2BCoGP
	nyILcWIEnYsuuxuwAy+3DE0xsc4m0vBRAOW+g67OIrhp2HiOE92IvzzfWLx9+IcBS0rhJ4fXgOf
	XO85Nd/DrQz11qmx5HXl/NVMyrXd1bxUCm7lf/jwV88392FnJPdjFeHd7RoXvStI1Cd6EpVvceh
	b+UXoEWrAh0JbvDEvHvku4UnnBjiYfcAjSgYEXT8cOkh+7QzRwb25WmZ+lw==
X-Received: by 2002:a05:7022:629a:b0:119:e569:f274 with SMTP id a92af1059eb24-1272f778d6bmr3982c88.29.1770832217504;
        Wed, 11 Feb 2026 09:50:17 -0800 (PST)
X-Received: by 2002:a05:7022:629a:b0:119:e569:f274 with SMTP id a92af1059eb24-1272f778d6bmr3963c88.29.1770832216903;
        Wed, 11 Feb 2026 09:50:16 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a636095sm2708226c88.0.2026.02.11.09.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 09:50:16 -0800 (PST)
Message-ID: <61ec2d75-38ec-4ee4-b447-3fbb723f59bc@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 09:50:15 -0800
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
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260211
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UUrt8CWh9Zr4RzVo9MTL0BXWj00TJhel
X-Authority-Analysis: v=2.4 cv=NrLcssdJ c=1 sm=1 tr=0 ts=698cc15a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=Y7CzE7BwRR1qakfplZkA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEzOCBTYWx0ZWRfXzmhxRQ4DchXY
 QR4vyNoAWMHHfGXQlPc5tdSdJFuKrl6Ow79/HytLDiKjPIyamJrNWesD8xJ9G9K7lSnih1wehFc
 PQMQzZbA0gQBKNpSx66RP7tUhkomUCv5QwG0tR/qRlA3KDojUs6iXL0BbhVEghow2cLYOhho0wV
 q5RyeOr4ZfIRoDvC6VNfdFUUqCzSjnWiGsgY4LqhGM2RwEXDRqCfc92Id0h3hq7M84V6Dib3vjX
 r/VydsEft+4uWb3gmA/35V24pD8MiWiECe0qTGdo1weP1pETs8agoPHemW7brRh+WFPzEp8i/7M
 dwu08F5v/Z1uBSmMFvH6nCEUeuXBV1mn265naSIWlze4woaxtyF4aWBZi32wqgV6hxbSXsxf7MV
 Rd3eGrtf2/MbHS1AZ21Ziy+sIiaiz9Vpy/+VssuUzbG/CXrLa6Yu9BmJZUb9smqffg/UXeIS0tz
 2RJA5Hj8wBoERHaI2OA==
X-Proofpoint-GUID: UUrt8CWh9Zr4RzVo9MTL0BXWj00TJhel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110138
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
	TAGGED_FROM(0.00)[bounces-31742-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C7EE126B76
X-Rspamd-Action: no action

The following changes since commit d87f4693ed96d0f3f6f16b0f09be42f3b8acb9e0:

  Merge branch 'robot/pr-0-1770665774' into 'main' (2026-02-09 20:06:30 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260211

for you to fetch changes up to cbd0f9753754fd9605df129ff04b0c4b4fc82568:

  ath11k: WCN6855 hw2.0: update board-2.bin (2026-02-11 09:33:04 -0800)

----------------------------------------------------------------
Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

No updates for ath10k or ath12k

For ath11k:

Update board file for QCA6390 hw2.0 to support:
bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=Xiaomi_Pad_5Pro_5G

Update board file for WCN6855 hw2.0/hw2.1 to support:
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255,variant=HW_GK3
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=18,qmi-board-id=255,variant=NTM_TW220

Please let me know if there are any problems.

Thanks,
/jeff

----------------------------------------------------------------
Jeff Johnson (2):
      ath11k: QCA6390 hw2.0: update board-2.bin
      ath11k: WCN6855 hw2.0: update board-2.bin

 ath11k/QCA6390/hw2.0/board-2.bin | Bin 173980 -> 231980 bytes
 ath11k/WCN6855/hw2.0/board-2.bin | Bin 7117076 -> 7237392 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

