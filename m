Return-Path: <linux-wireless+bounces-36401-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAfuGqErBWqJTAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36401-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 03:55:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87553CE2D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F48230125BE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C63033C0;
	Thu, 14 May 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9xiCcgM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZI7acVA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CC2C08D4
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723738; cv=none; b=XUakhZK53FbeOMnOwApXJL88PBFhmz1bdfySt3c4pOmgtOP0Rxn1x2iQR1yetOcw/xYWuKSoawCJoAGDVTF0kfUn96reFVjXamwVNs+AP8NmdgwKTXqINoeLaIUl07UjWW3B1lwgoyz6rsaJ9VQNv4u2tbxoawag40Cw6f+Vd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723738; c=relaxed/simple;
	bh=5v8EeRac+cyfQsooBk/OV6PWZwj7rYK6sKAYTENQb7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv+oiVGeiLyF3u4b6t4meFZIULVlDRneOebjsrwgmOiYz5jH01xAlVJUFtKhIMVsESwZBvj634cALKs/LYefj6l+Mzbysk5QIOISKw1tDK4chXX0L80PKuHFtElalhWGsSLdatPT4DaP7tzxXlXlAG/Id4NF0G2povSc+djYThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9xiCcgM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZI7acVA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DG8i7N3007155
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 01:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiHAcjhRthz3rvDhKLHFzNKvMGqnqTuRtCwLpz/oefs=; b=L9xiCcgMkkPS6Y1G
	z1ZZlhC2lZib/yKUF9ZBho9yO5NpKP43REn3tSLA4k1PNBLiLZJwmyic0wWnC1sT
	UHbxQqkLMXDIX8/0flcDSOkIx2JjHDihHxtRufv09ddrnB7GG1mWuB8drXOuVQjh
	PCZikmddMWxhsJR8ieOmmR0jVDv86nsMgaAVj+9qOgDWtJO+cfEUW+OTlSONDfWE
	cHwpJxsStF4JzPya2UzVBBuYev2qTFYYYL/+g4zJNE+hkwTsE+n/W2OlR8N+CdcD
	M4HVr7W3HyNBBK+aAkIbYHfkZEOLt5Aho+rQWW8gT1pYB1rAJjMgIl3IJiqk1R6B
	D3nOEA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0kauy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 01:55:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2baedd2fd43so45986675ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778723735; x=1779328535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiHAcjhRthz3rvDhKLHFzNKvMGqnqTuRtCwLpz/oefs=;
        b=JZI7acVAd2S+oVEWBPr/RWzdmJe3rIMqmwLJhwjheKTw6f0FUjvQU510Ev6DM8pZnr
         QvdRgxavU1Mtv5L/aUSmDd4h2MncA/WN27q2VeH0BZ5JUoww2tNr3TXl+ljfqZURcvw6
         cvyq7QT4OyXXpTJ0FNwG5YaOlJIDil0LBJTPVD7tkT+5q6sNwF8N+Crne4Wh5oyjATSn
         bTWNFGzKEDV+b7luECTLbdGNEv+Wmojzq9W0oGzG3PrpWLXq16k050j6jB6zbPf2Aa/Y
         ZuVkaQNL5DP8QgJjvA9czsDH7ODS/N3/XSmpTaOJ0gWOaxKFckB7z0RpG5ef/aB1Q5gX
         nrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778723735; x=1779328535;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiHAcjhRthz3rvDhKLHFzNKvMGqnqTuRtCwLpz/oefs=;
        b=reh0Br00JAX7ekjrlnq7IK6NfYfrIrVGZndnec5MdPLb4m5kOS+2Ay99955ZWbXO4n
         PRDbMpUhSjpKUBGVX/N8CYIPNRMbr/3FvG5NrmIfened0u1I+wA3fysXm5GOkhHQa4cJ
         aZ5zg3JMbHidfpnzr5REmB6lTbtxc1BF1LKk6LuumJ8Y1pusJ1zmJ7xRrTpJ46aCrxLK
         8+uL2oNB4W0X0tFkPP39MpysQ/Y/bhJlQtMaByazScUgenhOnVBc0nfO1AgSEHvPfCvI
         ekOn+z3rxUTVvOCycoQCGyk59e5TUhh/naiTsxH5xBxPVUvO/xTU5N/JpSR5nKP5pz/A
         K/QA==
X-Forwarded-Encrypted: i=1; AFNElJ8KjnttHymNKyxQ+njj/3avT2Dm/X22vorHH6chY+EPRl1ZsjcIHISufJugZp3/Z3ViZZEMFdqPcm6ThPS5ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6CX/lAGfuEXObkWkpg4egaEBiQaAeJpPVT8ZlT1v9eMgmsyB
	dbCt3WGaEjhI0sTXfnirTSasUzaBGXKbttymol+cI1X9kq94Jt+7ch2myI1+Chw/PlxAj4CJUqV
	IDJYOYmz3fkVaPAeSgm5NJCR5Mbn9yK0LZeMgbYq6gk6I3t0Jyu5Uzqiiw917Tl3wT7Dj3QSEM6
	Sv5A==
X-Gm-Gg: Acq92OE6kKM+7cT8F8FhI4ksoKy68lO7mekN31LQ9QH2RJtc1NwTISPSXbGe4MWQ7f6
	zR6cP9vYo3anObZytNgnsekwTj520SHdZwV1cR89cTzCz3qalsCEsJ8vaIGO+6uYLPc85Y6jN0/
	+eKbM+Y+4oROLQVnZIsGAJliKoBO+d76GTYIu4vYUjE/XslQRoDjemdj6rxyl2GkxApRnj385Rq
	tazvP7bfdHE3qX8gdk4+d6SkqOIrYM1YWkHIQemdW4bEx7bVoc7ZDLtMqVQ0BLlX4wfK0TqwI4H
	Bc4IhhBtRdXtEh+sdfI1GSfw9biYXeGIqf6rtql333zOEsSuzOoxpT6Hut+CYBqx9PESnDkFOVb
	4WboK175lZlUv4xHC2e8Ae1VKHkqlpM6vo3pGHPfvXLWOvjmF4eLdzlyoAHJ/Zwe0ZsuNFk+mbI
	STw7W/h6hzlQZFcp6jO8/ofIuiE0PPZQ==
X-Received: by 2002:a17:902:c944:b0:2ba:6ffa:bded with SMTP id d9443c01a7336-2bd3032f994mr56183295ad.37.1778723735081;
        Wed, 13 May 2026 18:55:35 -0700 (PDT)
X-Received: by 2002:a17:902:c944:b0:2ba:6ffa:bded with SMTP id d9443c01a7336-2bd3032f994mr56182855ad.37.1778723734389;
        Wed, 13 May 2026 18:55:34 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb35sm5736575ad.12.2026.05.13.18.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 18:55:34 -0700 (PDT)
Message-ID: <0ef41d1f-e9ec-4f90-9f6a-77cb8fa3a7e7@oss.qualcomm.com>
Date: Thu, 14 May 2026 09:55:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k WCN7850: Q6 Hexagon fault at WLAON region 0x1792000 ~2s
 post-AUTHORIZE on X1E80100
To: Marcus Glocker <marcus@nazgul.ch>
Cc: Maxim Storetvedt <m.tvedt@tutanota.com>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, jjohnson@kernel.org, kvalo@kernel.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
References: <g7dkeq3uwg7eby57zcuu5eysf4tqomh5civlvkpnlziipn6xis@45eevyzgfmaq>
 <0b450204-9afc-4ba1-b9c5-1876b5a7078a@oss.qualcomm.com>
 <tzkh5t3bmiqff67g72rihapizz2u2dlj4xfrr324d6yg4rtltt@3qrsymzw7c2c>
 <92ace4b9-143e-4962-90fa-215a22e24796@oss.qualcomm.com>
 <cz6dbqafvulifyrefsxzwrlq5z5uojylphqkq5oydbn2bvcns5@bhj3hr2rvxhq>
 <fxrzvhcrbkugzfzmj6h5netczccav5hxfefzyns67t5jhakk5w@pp6addxjkdb2>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fxrzvhcrbkugzfzmj6h5netczccav5hxfefzyns67t5jhakk5w@pp6addxjkdb2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxNyBTYWx0ZWRfX47D+RKLeaUay
 vhJC0TI9iUPqXrfzrI4YsPCYZbZe5IT74Y7QsmANk4H4Luul9KDRFb1qS2yoY8MRXm1ke9EIhaQ
 P+BLWtp5xLx7H+iI6Qoxr0KhD04qdir1XCIh/boKg/D7t4AQ/7ox9bQt3hTLCjS1hU1lLlcks+e
 rKaFi89kDDDtjkU6s4q+285ymwzVqvpjpULjq06mwUP4nV3dt/U3dlB9kYfJ/gxnj5E7/7qmxVk
 ymajE2/6r7xJDz3JglkCzcjT1nApYLyO+DC/gTECXacfI2EUpQ9GIiDyOJBFr2k7PCPFtoE2A/H
 AWzI2B1Vpwqf9Ev33QfkXTvBR3kjaIEJU+F7cDD1W633MkCD5XgUA4TMLGAzln3nmzRa4iaTGvn
 QdOa9vMuP9S5blZZFQz74yIchZ7cM7L1ZxtveSeO/pfpW+5o4xYaj/+oWNQ7vRvi7La98Gjwp85
 gR+PEhpVaWJf2dO0HIA==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a052b98 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=E_MRXsYlAAAA:8 a=juP3Sl5wJPrPkdtuZ-8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=486ROa2Zizi0ivMXnIml:22
X-Proofpoint-ORIG-GUID: EhMByRHZPdxz6PnP_nR8Ws7kCmXpLppQ
X-Proofpoint-GUID: EhMByRHZPdxz6PnP_nR8Ws7kCmXpLppQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140017
X-Rspamd-Queue-Id: 6F87553CE2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[tutanota.com,lists.infradead.org,vger.kernel.org,kernel.org,xs4all.nl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36401-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/14/2026 4:47 AM, Marcus Glocker wrote:
> On Wed, May 13, 2026 at 01:26:50PM +0200, Marcus Glocker wrote:
> 
>> On Wed, May 13, 2026 at 11:05:05AM +0800, Baochen Qiang wrote:
>>
>>>
>>>
>>> On 5/13/2026 3:59 AM, Marcus Glocker wrote:
>>>> On Tue, May 12, 2026 at 11:38:06AM +0800, Baochen Qiang wrote:
>>>>
>>>>>
>>>>>
>>>>> On 5/5/2026 5:08 AM, Marcus Glocker wrote:
>>>>>> Hi,
>>>>>>
>>>>>> We're porting ath12k to OpenBSD as the qwz(4) driver, targeting Samsung
>>>>>> Galaxy Book4 Edge (X1E80100 SoC, WCN7850 hw2.0).  Scan, auth, 4-way
>>>>>> handshake all complete; ~2 seconds after WPA2 AUTHORIZE the WCN7850
>>>>>> firmware crashes deterministically with:
>>>>>>
>>>>>> 	dlpager_main.c:147 Non Page Fault Exception cause code 0x 23
>>>>>> 	at Address: 0x 1792000
>>>>>>
>>>>>> Cause code 0x23 isn't a valid arm64 exception -- the fault is on the
>>>>>> WCN7850's on-die Hexagon Q6 DSP, with QURT's generic exception handler
>>>>>> (which happens to live in dlpager_main.c) printing it.  So this is not
>>>>>> a host CPU fault.
>>>>>>
>>>>>> Per the RDDM segment table (at the start of the dump), VA 0x01792000
>>>>>> is the start of the chip's WLAON_DUMP region (size 0x820).  The Q6 is
>>>>>> trying to read its own always-on hardware state region and the chip
>>>>>> refuses the access.
>>>>>>
>>>>>> (Samsung, Asus, Honor) with multiple FW builds.  Currently testing
>>>>>> with WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
>>>>>> (fw 0x110cffff, 2025-06-25) -- the exact blob a Linux ath12k user
>>>>>> runs successfully on the identical Samsung hardware.  Same board-2.bin,
>>>>>> same compiled DTB (upstream hamoa.dtsi based).
>>>>>>
>>>>>> We've field-compared qwz against ath12k and ruled out (byte-level or
>>>>>> wire-level):
>>>>>>
>>>>>>   * QMI host_cap, m3_info, wlan_cfg, wlan_ini, bdf_download (all
>>>>>>     fields including ce_config, svc_to_ce_map, shadow_reg_v3,
>>>>>>     feature_list, m3 paddr/size, nm_modem)
>>>>>>   * MHI bringup ordering (BHI -> wait SBL EE -> wait M0 -> BHIE)
>>>>>>   * BHI/BHIE DMA coherency
>>>>>>   * ASPM disable before MHI start
>>>>>>   * WLAON_WARM_SW_ENTRY zeroing + QFPROM_PWR_CTRL VDD4BLOW clear
>>>>>>   * static_window_map=false + window-bank register init
>>>>>>   * Per-chunk vs monolithic respond_mem allocation
>>>>>>   * WMI_PEER_MIMO_PS_STATE = WMI_PEER_SMPS_PS_NONE (added matching
>>>>>>     ath12k_setup_peer_smps; doesn't help)
>>>>>>   * FW image variation (c5 and c7 both fail identically)
>>>>>>
>>>>>> Specifically NOT involved (we have evidence either way):
>>>>>>
>>>>>>   * Gunyah -- X1E80100 is reportedly run in EL2 without Gunyah by
>>>>>>     users where ath12k works; so Gunyah isn't programming WLAON
>>>>>>     access for the Q6.
>>>>>>   * SMMU / pcie_smmu -- pcie_smmu is status="reserved" upstream,
>>>>>>     pcie4 has no iommus property; PCIe DMA bypasses SMMU.
>>>>>>   * SCM/PAS -- ath12k's PCIe path makes no qcom_scm_* calls.
>>>>>>
>>>>>> Question: what subsystem inside the WCN7850 firmware touches the
>>>>>> WLAON region at 0x01792000 around 2 seconds after the host sends
>>>>>> WMI_PEER_AUTHORIZE?  And what host-side configuration (WMI command,
>>>>>> HTT message, MHI state, etc.) primes that path so the access
>>>>>> succeeds on Linux?
>>>>>>
>>>>>> Even a pointer at the right Linux code path or the right FW-side
>>>>>> component would unblock us.  We have full RDDM dumps and dmesg
>>>>>> captures available; happy to share off-list or as attachments.
>>>>>
>>>>> please help collect ath12k successful dmesg log and qwz failed dmesg log for compare.
>>>>>
>>>>> Please enable verbose ath12k log when loading ath12k driver:
>>>>>
>>>>> If you are using the latest upstream ath12k:
>>>>>
>>>>> 	sudo modprobe ath12k debug_mask=0xffffffff
>>>>> 	sudo modprobe ath12k_wifi7
>>>>>
>>>>> If you are using an old ath12k:
>>>>>
>>>>> 	sudo modprobe ath12k debug_mask=0xffffffff
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Marcus
>>>>>>
>>>>>
>>>>
>>>> Hi Baochen,
>>>>                                         
>>>> Thanks for coming back on this topic.
>>>>                                         
>>>> Attached the OpenBSD dmesg, with full ath12k driver debug logging
>>>
>>> the dmesg shows several WMI_INIT cmd instances which is not expected, because in normal
>>> operation this command should be sent only once.
>>>
>>> cat dmesg |grep -w 'sending WMI command 0x1'
>>> May 12 19:35:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
>>> May 12 19:37:20 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
>>> May 12 19:37:41 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
>>> May 12 19:37:46 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
>>> May 12 19:37:50 x1e /bsd: qwz_wmi_cmd_send_nowait: sending WMI command 0x1
>>>
>>> other than that I don't find any other clues.
>>
>> Yes, that is specific to the OpenBSD NIC framework.  I've just tested
>> a quick hack with which the WMI_INIT cmd only gets issued once, but it
>> makes no difference to the firmware crash.
>>  
>>>> enabled, plus the resulting RDDM binary after the firmware crash:
>>>
>>> how did you collect the RDDM binary, seems not in the right format, my tool can not parse
>>> it correctly. Looking into the binary, at least the magic 'ATH12K-FW-DUMP' is not present
>>> at the very beginning.
>>
>> It looks like ath12k wraps the raw RDDM dump in some ath12k firmware
>> dump structure, which we don't do with our driver.  I did write a small
>> conversion program, trying to generate the dump which you expect.  You
>> can find the converted dump file here:
>>
>> https://nazgul.ch/pub/qwz0-rddm.bin.out.gz
>>
>> I hope you can load that in to your tool.
>>
>>> And from which Linux version you take the ath12k codebase?
>>
>> Well, that is a good question.  qwz (the ath12k OpenBSD driver), is
>> an initial clone of the qwx (the ath11k OpenBSD driver), which is
>> functional.  On top of that we did changes, of which the recent ones
>> did sync missing functionality from the Linux ath12k driver.  We did
>> already do a lot of comparison between qwz and the ath12k driver, but
>> we can't spot an obvious difference which could explain the firmware
>> crash.  Obviously doesn't mean that there isn't a gap between qwz and
>> ath12k related to this issue which we don't see.
>>
>>>>
>>>> https://nazgul.ch/pub/qwz0-rddm.bin.gz
>>>>                                         
>>>> The command sequence on OpenBSD to re-produce that was:
>>>>                                         
>>>> ifconfig qwz0 up                        # Bring the ath12k device up
>>>> ifconfig qwz0 scan                      # Scan for networks
>>>> ifconfig qwz0 nwid nazgul wpakey xxx    # Start association
>>>>                                         
>>>> Hi Max,
>>>>                                         
>>>> Since you have Linux running on exactly the same Samsung Galaxy Book4
>>>> Edge 14" laptop, where ath12k works, would you be so kind and also
>>>> provide the dmesg output showing an successful association with the
>>>> ath12k driver debug logging enabled?  See above how to enable that.
>>>> That would be very helpful!
>>>>                                         
>>>> Thanks and Regards,
>>>> Marcus
>>>
> 
> Hi Baochen,
> 
> I just want to quickly let you know that we did overcome the firmware
> crash.  The culprit was that we did
> 
> 	#define RX_BE_PADDING0_BYTES 80 -> instead of 8
> 
> which did break the hal_rx_desc_wcn7850 struct:
> 
>   struct hal_rx_desc_wcn7850 {
>       u64                          msdu_end_tag;     // offset 0
>       struct rx_msdu_end_qcn9274   msdu_end;         // offset 8
>       u8                           rx_padding0[N];   // <- the bug
>       u64                          mpdu_start_tag;
>       struct rx_mpdu_start_qcn9274 mpdu_start;
>       struct rx_pkt_hdr_tlv        pkt_hdr_tlv;
>       u8                           msdu_payload[];
>   };
> 
> With that fixed, the firmware error is gone, and we can now receive
> and IP from DHCP.  We're working on getting the TX path work next.

OK, good to see it gets fixed!

> 
> Thanks and Regards,
> Marcus


