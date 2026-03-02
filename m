Return-Path: <linux-wireless+bounces-32351-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGobD+KxpWk8EgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32351-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:50:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BF1DC2C0
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CA730D950E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DDB326D75;
	Mon,  2 Mar 2026 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ml8cWgaZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rfo00Jak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0F411633
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466357; cv=none; b=gtpoSD+MBs/xcZ7Si2Jq/TLjRXRS2GJCyDBic7NZSDXEqFCY9MFKtGw4sxYS42MUmAJzKMiTejCXUKqQNxcrxLQD1KcQdzB1mc5OJrkIUMpPrdu0LnbfjsqXK9CvEpj6LWQKlP+PK5b2T09xFvDNPfByBmtCDPvUEpeGtSKFLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466357; c=relaxed/simple;
	bh=Qw8o/rCLPy/vpohRDo9EYLsdqvdo0ioSF2rnnIGBL5I=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=JcLgKCTkSUINhlrOCodsVmjlMzehaGLeHblm8nvFweUgnBZD8uauVV6Z6v78lgQXgGqH/ZHI9XpszRxW1iIPdQLIHUZtPYrQu69Xf6KQovE4uBvOtxT35HdJ4gmct+HkbVsHVLE8/Kmk/z/KgOItfoMBlajRRqALphJ7sr75GQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ml8cWgaZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rfo00Jak; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E0GHi055231
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 15:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mBzcckmfYCVo7odpi5kuU0
	OBvpH27akeSOBo8YM08RM=; b=ml8cWgaZwe545X0cKY+uG9aA5asSwZdUoYE3st
	Jsad7DdbRW1PIPYImxAeHSOc8hVd3/VttMb8SmkJB8bcGyiZq3Q0ZeBboM1PBjmf
	QL30IQWUTT3dZDyLvhydj2hpG9EC97dKck60yO1vBMEpvhxBFDVcHyennuJyrpfN
	4Wjrhb1fxQ7Ny18TNfrg3WuExi2PglT91NAspFLawvTyHlf5syVkL19slUzGgrDz
	3oTRnDfcDmHUzEhxw9zNq1YF4fseBGHHbtk5NSu50SPJnzMOL9ecP0efg1hq7jUj
	ZZ6jdVX2qV4isYRVrI65D125KrM733APfgyoOA2T3gymCefQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw64b0kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 15:45:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2be191ce356so727334eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772466355; x=1773071155; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBzcckmfYCVo7odpi5kuU0OBvpH27akeSOBo8YM08RM=;
        b=Rfo00JakH4soQ0Y6jcFxk0aa44WmzcO7kz6L9uWYhvTpixaeYRzVrq+0KcvFNWZNbL
         s1reWaPVjhyGUgPnuGJbQjlEUCcuzcOQb1Kkp97Uu6nfoJ1nOpY6owFQqboc/KW4GdiR
         RQO3Lf1EBKoN66FnlCcqCPi3Ouxsx5fg/YpzgiLH/8R9F70nZ57VWMLoOu9nD29tKjXT
         15sSuSxCOqQjvp15d/HjvK6/gJ5bKi8mrU4D5WAIty52PtUlmtdvqCA09d0ePnSgP4gw
         L10/qrWvDb3y2TEKcV3008iO+qP3V2b3moedKtocNF7lTCzS/SVU2mfzHPdZsfxF3dh5
         JqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466355; x=1773071155;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBzcckmfYCVo7odpi5kuU0OBvpH27akeSOBo8YM08RM=;
        b=MvxhpA9iWw40cuRUkRgtM2tCKy0htEvsvXra+3DogoS3h9Bl34uBjsGvnhxxdSmIhN
         0MvwiOf6l4j/QgrOdHT52lFAjMhPwv1EgHBcdj3yLcJ6ITTa7hOl3XMYuYKlwrOLtuQj
         o8lRpF0JG2dTQPauQFtKpPjs+zp9XzT7icxPDV6BThdnTNOYG42uAma2S1ae7Mnl7IU6
         QsJtVHM1bQW1KdFNQyRZ44W+EJJzgcEoM3WwK7J/3YkQ768/0ZdOtjCutjq9XzjT8Ct+
         40rcJzPPYwD3/z5zcNVujz/75jMi+OjzKr0Dbd00nALhWoEXXVNIyn3Zn++JXhCGRR3N
         eo+Q==
X-Gm-Message-State: AOJu0Yy5qRRbOCjKkHAitI4nCbuoEC2KYsxhp7tS+z+oJ+yeNsp+8Hcy
	JSch7Rm1ydLGpwXGc+9BEg9ZlfVhK2zjzUupmoDBS7kRrLjkTJFJF0qD4drVmOqCM/AKTiRyBDx
	h7GK27kBQlYDajjGc9pVW69RB8nlk6KrWIkF+VzqYcOs0tizr3jG3KklQD5GKqRaNl3vHZB65HV
	WEpw==
X-Gm-Gg: ATEYQzxfg9VHobl2Sgi3X9IXhCBEvxmgXF+nuKA+72pzAtPhYRKHZYHp3MkFGx0MXLc
	6FRT+tfET7b8tAbw2PM5kUDfq+S6SEaNdmpDPHYDOgmfFtV47f+DlvsrazCgQkj7tiDt0p90gfP
	jw0jlBfEQaD5sipNAm1mvWbWIHLmcbT7Wn8XX9tO/i3h6renaAJeyrnZM1SD/cyxyhyUF6C64Xu
	rL+eIyX9xsO2/1rKEvtXX7bLx8RSqIUfyL3BD8r7x4zvPIEglsondzWVmuy/r8bKKirUuTjXlhh
	QOylShgIdjlubC6pxWXM2jyQIDgi7TMjjWDtrqRzKfOVOfoHN/mxtWNpxhWnUN8CV36prkLLs2A
	TD9fWVElndCtkkx52pOLrqH6LfRm27y7eu6tm8PBmKUFQcTm0bdaLW0gj/g==
X-Received: by 2002:a05:7300:880c:b0:2be:e4b:60bd with SMTP id 5a478bee46e88-2be0e4b6291mr1135155eec.6.1772466355133;
        Mon, 02 Mar 2026 07:45:55 -0800 (PST)
X-Received: by 2002:a05:7300:880c:b0:2be:e4b:60bd with SMTP id 5a478bee46e88-2be0e4b6291mr1135142eec.6.1772466354486;
        Mon, 02 Mar 2026 07:45:54 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f7e955sm10988694eec.32.2026.03.02.07.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:45:54 -0800 (PST)
Message-ID: <830f20b3-076a-4ad3-8cfc-5920c66e3f35@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 07:45:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260302
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HP34wAMwHVHVSL_4QpEGsYtS5by18yHX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMiBTYWx0ZWRfX/oAVauBsp883
 WXSOIxTwGQc3C55UQyWewMPD5eX+63GHbo1ZnszQUHm/kHvLp0PubyxZLLWEhy95mF9K5OnaWZa
 7zJGoga3MCk/f9Iey/zQU16+KMPXxgnwSQNqAC6er2vDv052+5IioPoCvzWIe3U5vn8hEHJXgH0
 fzsd/hSLBDYZvyODpFBmPiT7X4X8up9+j42HmRMYendXtPdTC7bj0QB1RF69Oht25svbV1gL0UF
 nnHqXmNymKWA03SNPU0RULz4tBeb6M6HYNhj3GooaTFx2QHJcKPGfcKSYhrDVA2jNQufGVyoA0V
 /WQZdPaWZkJMBbJE5vzk4hRFaB519+z3afi5tzVYU0Pc+2D6fRHTuC/YnOmkEuWf934Qw+qMW4P
 bcGjTCsPg8kxiCgjHNgU0rFfduIxCu8HI720WU+ehG7p2a8MLmj3qDvc5yy3+Vln4df0IjWVoqK
 nfKz1cFVvkc0wmNZNNg==
X-Proofpoint-ORIG-GUID: HP34wAMwHVHVSL_4QpEGsYtS5by18yHX
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a5b0b4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=FL5DRaERdKlnwrn6VaMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020132
X-Rspamd-Queue-Id: 4D3BF1DC2C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32351-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The following changes since commit 017c1792525064a723971f0216e6ef86a8c7af11:

  wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame() (2026-02-24 10:03:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260302

for you to fetch changes up to 7259b1a0e54c2d3051ac8f1eb01de121b11118ea:

  wifi: ath12k: fix station lookup failure when disconnecting from AP (2026-02-26 07:18:32 -0800)

----------------------------------------------------------------
ath.git update for v7.0-rc3

Fix issues with ath12k station statistics requests.

----------------------------------------------------------------
Baochen Qiang (2):
      wifi: ath12k: use correct pdev id when requesting firmware stats
      wifi: ath12k: fix station lookup failure when disconnecting from AP

 drivers/net/wireless/ath/ath12k/mac.c |  6 +++---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++----------------------
 2 files changed, 16 insertions(+), 26 deletions(-)

