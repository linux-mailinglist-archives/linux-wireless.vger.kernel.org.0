Return-Path: <linux-wireless+bounces-32308-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJdEBGOPomk04AQAu9opvQ
	(envelope-from <linux-wireless+bounces-32308-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:46:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 671201C0A36
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 07:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F70B30360BB
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Feb 2026 06:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB445038;
	Sat, 28 Feb 2026 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYBKBC0o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKxw6Pic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EC17A2E8
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772261214; cv=none; b=VoN1lmqi1sCFtVzGTUz4bf+orbiJrS7uLltdPsezQb73RgjLrOo83E2mYwOKGNuM4st+OEKaEhkmLa8WAT2vuVOUJSrPO8Fapi+K1jIvJ0cu9tnKU+KrJkE2oKiCE0vDTE+qHsFJnS14fmWJyR4AljivfjJDT7ECA4RwpKc4vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772261214; c=relaxed/simple;
	bh=Mw59oOWsF56xkalFjOWEenEdSDSBfhuwA/J/vaU6cFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkxRmg49QLSQ940tpdHfUx4Q7+lnWV7XMfJNQLQCQssYEVVLsRiwdOvzbS/+IzZWnytJIq2IUHfS3t/xNaQRrQbH6FU299c7VgfKu+Hn0RggapvBlf47a8cCVdfv0WMaz6TuTVo7apaJNJbnPaYGZTDsBMLfrliJgNnaBdeytwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYBKBC0o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kKxw6Pic; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S6OpIE3037637
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+5HRmL5LS7Bo75m18iXU8GhRBHVClnflsqj8BTS5pDc=; b=JYBKBC0orY2gKW3b
	bIqVgm7mATzhhQZrQ2Sl0oLRmqo1inGCqiZSTEgvsTTNlIarDulOE7i3H6eXvayz
	3hqIxoCVqY34ZFRIJt6WHJf7pDK30EGpk0oUWoinA/atFDfoUygHvHcrl3iInKVl
	KpDg6XL9u7nK1tpKbqLefHn4IAnMGu4laKVIPTtR9d5ShKFPX7JFazb1bXz1kTic
	thRJRxeWEdRVI+EgpeBHjg6QoBf2Mugx29FW9mXciLHlqyRRBc0gT9mO/Sc/eotG
	fCn5iU3fmvgNUkgTFEPpmcjLV/2E8NW49BxVmAeHuh/CmMnpoSMfqm+Me4OPzjpE
	JJ0aEA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksfyr93s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 28 Feb 2026 06:46:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6fd07933aaso1573980a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 22:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772261211; x=1772866011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5HRmL5LS7Bo75m18iXU8GhRBHVClnflsqj8BTS5pDc=;
        b=kKxw6PicRiToWcmeqKf4+g2PHbneWYmzT2Y8Ya10xd7NaKv9UfcE8yHF+DvdC9LkZM
         AOool0Ne1NmOrHxgqv0G4HzwdlCxhHyS1aNusqv2cnSTr64Ft5mq3gLV4hl/EBgqV9vE
         4M6CvET9qJYyjfd6itwbV8kbEB5KIVOU1t0DxEm8iEJN1AxiS6iTZYfzsrPrqkEepbcZ
         WzlcwO19/lqHj53qbVTT4EHScYLVxtf0hTCaBOaGLTAbDGkY7qtEZk8nAw/JH00nX3k4
         gvqqRZ6amkZCDdJvPtvSnM8sdvhJ2B/6RmQcCN3g8mLCMgn7Dz+uHHo3FXJBT8bO1+08
         tvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772261211; x=1772866011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5HRmL5LS7Bo75m18iXU8GhRBHVClnflsqj8BTS5pDc=;
        b=fq+CCi0LW7sY+w3d1aT+SKWhTn2VgBWDDx+yC20GWvzxnYUWYgFz1WrjocxOv6QqFo
         W9gKnMotqdaUVOOtIQaJtlhSf1UEtF5yLMdCclbTR1FChMUl9YpsABeNuyw60wWGQIPR
         br5niCbG+wz7Uu8wHWZ9ZTHbIfMknl1XzZy6vOPzx2kSTnFY1GdDOxkXDAdiXLKNZZWC
         6yGsZq4sIyfFYBOgpyXfc0DFctVidE+3tEqbQ5MMwXoddHsBFEbB4oDl9zEHXbohJIis
         nIw0YdRd9aw6Qq8E0mp7NJDsB7ABChX78a2TeRoaNmQJfZm2xuNMC2arTS/o6L7enBm+
         LUOA==
X-Gm-Message-State: AOJu0YxhgemAtQj2E/8+wHyquENC8uiAILBrZIcbBVEnbimwPRe6ONs3
	fouI1Q92q/jJthEnrX6LLftz9em1fNmP0EGAZdFsHbZM4gb0k3CXkCjk1Z/Wz37ClnwgIUsTJHm
	NvZQKGU65eVYue/oAcVfQf5VttTnb75SPMQfz8JBHtMyH+G12Ll2T2pHdciphNYgSNqXbfg==
X-Gm-Gg: ATEYQzxRXHocEBGsXAwsPMR8Khw+orIn7obuodtXugoFHpfsLw4aLZY4AAS2lRKg4NF
	F4Y8Z8/T0SGE3Ci1T3HAiAM2apt1TZJ6BFI+ZQMeO9x9roHkIJAFVk/R5ttPO81y5vDZZoxUPAl
	oaJbdm22cUxzlvQQAar0pmRkIA9JNpNdnPebV9BfQ+JIWHx3mMJcpMXLcoh5j6mH7mnYlLN4XpS
	mxo0iHgyrGqgYVGLBJJCF/mVJuC3hL3jclta4dIYx055dBoDtdq9QeVA7UcQIopU4LlYzm2hJ8r
	it2zHq6y+5VyfWtz5Fc80pVEPbYkslv43ZEzuG8FGq8UifsXgirxr2In8bwiFTWyTqq2nzysNrD
	GeVjLCW5r+kmXn8n8AXHoLEnuqf1WzkoB+IFhk5r3yzWi+M9tReMDHKFNf3bQRZwyuVk=
X-Received: by 2002:a05:6a00:3e1e:b0:823:f74:662f with SMTP id d2e1a72fcca58-8274da093aemr4890756b3a.51.1772261211004;
        Fri, 27 Feb 2026 22:46:51 -0800 (PST)
X-Received: by 2002:a05:6a00:3e1e:b0:823:f74:662f with SMTP id d2e1a72fcca58-8274da093aemr4890736b3a.51.1772261210506;
        Fri, 27 Feb 2026 22:46:50 -0800 (PST)
Received: from [192.168.82.30] ([157.51.81.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a99esm8637790b3a.47.2026.02.27.22.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 22:46:50 -0800 (PST)
Message-ID: <aabb1cf8-afe6-4ee8-8946-01c162c0a432@oss.qualcomm.com>
Date: Sat, 28 Feb 2026 12:16:44 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix the assignment of logical link
 index
To: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
References: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260226041911.2434999-1-roopni.devanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA2MCBTYWx0ZWRfXz2d4iLpN5kwI
 DZEJLlHgNt6aoOtVpGKcwk8PoS1pfsWIiogV00eHK31U53nfdozQg9vq2K4sK9vxSOE5tXt0zio
 vEimjnQO5RFbtK3Nn3AncPktqNnCTLwZj7znOjaLdqs9uRottdKCvoYseHc5wQoyHMR9KdkB1lj
 1yw6+1//tt29WSVBLPoOuPZUjqDqQOYmkeWLOMsQn8WQJODpM3qIxu7uGzGQ9vU5mkT34KP7FgV
 Ii86+RVGXdJliwt6kwDiOef/Ns6tgHlJs+RdOoHtgnkxJ972UOPqA9qa0/y0wPKRIvJK78PRzXl
 Ny1B7QOMwP2YY9D/lOcFgl5RwEWOc1y7KXihbFEI1BCpJxyi/5qWIAbIHEUWItbVtaPSwHhart1
 BHdwPfN4nI2bqWQMDbyic9nBed2SxMhN+ZtzOgH+UDtdIXdvY46+ejVL0UXpwbRDvbQwZ8HjOqQ
 o3xaerymXPSXEZjI14g==
X-Authority-Analysis: v=2.4 cv=avS/yCZV c=1 sm=1 tr=0 ts=69a28f5b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=246QjU3JZtZKFnheHnOONg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=YqZLIXxkOqM5MmwRYRkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 3Hye49YBAAoQp8mThzb8lrXoow78qNVr
X-Proofpoint-ORIG-GUID: 3Hye49YBAAoQp8mThzb8lrXoow78qNVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32308-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 671201C0A36
X-Rspamd-Action: no action



On 2/26/2026 9:49 AM, Roopni Devanathan wrote:
> From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> 
> Per-link logical index is assigned from the global counter,
> ahsta->num_peer. This logical index is sent to firmware during peer
> association. If there is a failure in creating a link station,
> ath12k_mac_free_unassign_link_sta() clears the link, but does not decrement
> the logical link index. This will result in a higher logical link index for
> the next link station created. Also, if there is a leak in logical link
> index as we assign the incremented num_peer, then the index can exceed the
> maximum valid value of 15.
> 
> As an example, let's say we have a 2 GHz + 5 GHz + 6 GHz MLO setup. So the
> logical link indices that they have are 0, 1 and 2, respectively. If the
> 5 GHz link is removed, logical link index 1 becomes available, and num_peer
> is not reduced to 2 and still remains at 3. If a new 5 GHz link is added
> later, it gets the index 3, instead of reusing link index 1. Also,
> num_peer is increased to 4, though only 3 links are present.
> 
> To resolve these, create a bitmap, free_logical_link_idx, that tracks the
> available logical link indices. When a link station is created, select the
> first free logical index and when a link station is removed, mark its
> logical link index as available by setting the bit.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01181-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
> Signed-off-by: Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

