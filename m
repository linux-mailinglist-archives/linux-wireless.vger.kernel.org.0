Return-Path: <linux-wireless+bounces-38258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z8dyOfoWQmoV0AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:55:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126D6D69C5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 08:55:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DpGk1AZc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=aSFc4P14;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38258-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38258-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BE03006B11
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9099398910;
	Mon, 29 Jun 2026 06:54:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C03890EE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:54:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716082; cv=none; b=i/bY29ozt6bqdvh9XwKQOkFcFSnYNJU3BcvhKmvbsLq+jl2GYViaeK7S9TCneVosJiSYYe379LdWcbFDN0qVde2RtjYMXh0h7p0tidwlUwDjw3KhRc/evmRTciPbKMS3nuvx5PdOjzon2Gb2DZ4RZwKTack1oqvEgO0TCQKFOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716082; c=relaxed/simple;
	bh=ehhRW+gUPMi/sp0KAV+JdHI4PP4aiUsdPCdzNNzAIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms6vaEKWvf7M+IR5InTPzV/ivzlszq8j8KhzJDXKfu9ScnTnEHhfPhXCgA/9dZSI51/Oylch9456qvxD41ygFBVX56KswZH7CTD3A9ppQfzjpc8M/OlJSo76dzcveI0h8OMjQJYTE+gDnN0vOmhShz0IpRIycrOyDytKu57vqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpGk1AZc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aSFc4P14; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rQqW2115954
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/4OQ+SJ4jk9cqK1TR2V/N6JmxkBM8IdFKcr2Nwmir18=; b=DpGk1AZcCsd/o4gA
	lQGxb64yxZxa4wDYrQE49HcM6afAkIqAW6GTqPEq3L33G1cSTygl1I6lbqx8qGs1
	SpRIo5QZDo/Bno1xJsLjVuIiGSPCm6wm+Vy7sr6oofICaTOz3cPcEl6fn6vxzaBH
	/SH88VFxm1lM4731q4DEN0efPrRpu+wCoRlz+mWyfk7sgFF4SjtVyzMpUZf3nJro
	PU1u+T49R3oJ+sAlTkX+xgR3H4CXzJJnyjL0YLx2rms1UL3Izh1OMQrQLc1ODcqr
	ako9yVSP44jYjqZlxuc+pnMQ3CvG7bJX01LVQjxphDGc+UbHv/0c0MP0pE0rr8iH
	xaC9ow==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734d60c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 06:54:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7ef28ce24so24133345ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716078; x=1783320878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4OQ+SJ4jk9cqK1TR2V/N6JmxkBM8IdFKcr2Nwmir18=;
        b=aSFc4P141BtOc3y4YwS7k2ZvpZb/bWUIYgPdaR+ja9d2P39tuqJOMRNeUJmlyeD2i8
         JCJ6Xw/0hFEOFy0W7zv6lbaOLgWeydzKOW2NcvIp47a8uobBPKRwACa0YlAZkyAq+Vka
         Z9dLuK6QuBtLzvxAXExvQETTIiSg1WCHTVzFTDdx1DtBR2HQjfMwRU2KIR4fHlnAd/ll
         BjE5wk00+Gg05TuC3oXkuPcS5sDTUJIdGh7BISTfj4bsnICrH35EI+MhbXFN3P/3+AtN
         GR6iH+hEBVfqkAU7yE2VdmDl5a5JRtN9FY1IpFFubk+szAE919Rr8hJd8ceCJp9SEEw/
         yoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716078; x=1783320878;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4OQ+SJ4jk9cqK1TR2V/N6JmxkBM8IdFKcr2Nwmir18=;
        b=Y5AzTE+g4oureN047ZQpX0Fd9DmdQswdEIeZuXpLz8mZFkZm6UGbjeEg2ANgMU8SuM
         RjUo91MkRXM6I0DBl/2hcbbCPVUKgTNJx5DmMXnSNIyxAEynu5J0o/qmPljfhHBDejbd
         xTYkoq8FD5frzqDdoZ8gy1hhYyGkLqIkz+kga/xP0t5MUM7+AmxZQKu9Hbvhiuu1Oapg
         MHdxiXAr+3sTHlwNepUPO/4sczy0aLUKqu45QZcd5FGxtWx/PkT1uaFnj+BBDMZYWqDZ
         ViaPiXdPwfZ/pwRaRt23WJRl9rzzfqDn/tr+kKh1Hae2ifQjtQoK3ejy9ZFUHieZ1HKE
         07kQ==
X-Gm-Message-State: AOJu0YzR9ACMLazJDcvm6ZFfzRObWV/G8GMgwEojI5KnLegZcIR+fTcX
	6xdnnV+QXssLowPh+WxfqWEaM6f+mmHbdsQPPVIXyzjlvd5+bGCAZ0H6XSXO7/gAIH7HpL2RFOg
	9MD9OZMJE0gzJgzYneLwG+buNoafMs0hEhoDLRWMJSG2Mwr4+IluyCqrnsMw8HKTjOM5enSh6sl
	iI5GNs
X-Gm-Gg: AfdE7cmY8LWQSboVwIqfG3niOZ8sFvgvD5+f13A0lmWTYATg9YM4QxeS0xQqFzGp8vs
	1SKRLVDOwyoq0cJlktLk40MqtaHAOJXz73x/scrKHrnQ40oR1oF+L9L+4mwP5H31gfDDghpjXnY
	VakTjh8zfKPHszaQOZWn0F7+JYImkmgNIHuBOoBuRqUOOGzL47BJnCrsI+S+E8GKe751m5Rbehz
	MIyPRW2WVr74SLmbsRsqGuNmeElulah+DRi2W7IStUIC/ROgVB6MdUvgQfseJA7wwAh9wuzqTcU
	jrZ4eT2YJfD8K8zRbxYHmAcFw7E6a2WHrmyFKDoL10pIWnYyxlKQL6/5HReFLXVZToJH+vEp0Q6
	F0UaJxcEBq6nATPrBXjeHtgP2mQgt/fcXYShNV6qZb+gYhBbqeVhk9lLs/0pD1eB95K7dzLJ54n
	1Lvgyl4g==
X-Received: by 2002:a17:903:440c:b0:2c9:992b:e88b with SMTP id d9443c01a7336-2c9992bea39mr66417645ad.20.1782716078293;
        Sun, 28 Jun 2026 23:54:38 -0700 (PDT)
X-Received: by 2002:a17:903:440c:b0:2c9:992b:e88b with SMTP id d9443c01a7336-2c9992bea39mr66417505ad.20.1782716077834;
        Sun, 28 Jun 2026 23:54:37 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9b72ab16esm36752075ad.19.2026.06.28.23.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 23:54:37 -0700 (PDT)
Message-ID: <9a4ce4fb-99eb-4eef-804a-52b28c93d409@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 14:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath12k: fix MLO peer delete race
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com>
 <20260617-ath12k-mlo-peer-delete-race-v1-2-ab3c4f455dfb@oss.qualcomm.com>
 <fa3d454e-e125-4aed-99a0-48bba9debe31@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fa3d454e-e125-4aed-99a0-48bba9debe31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EeptojL0AONR03c-JcrOZaNXyvrOU_jF
X-Proofpoint-ORIG-GUID: EeptojL0AONR03c-JcrOZaNXyvrOU_jF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NyBTYWx0ZWRfXxpEEbavI732P
 35j/gX7KZ/m0UGvBPCClMljRzyfopCrTuB+I4dRl+x0o+mvWg5pdz3s4Vh9FeGlUmeTuEr0YXpq
 gsstYvTXBzH7z+K+Sj5P1rpMCv7FnSo=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a4216af cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_u5qJjOYxTI9eUKrpbMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NyBTYWx0ZWRfX/9zR2Yh//age
 UOnOapjJSE5mujs4hIFTH0DGdiBMFTiF+BpVAkJ+Yk7zKBbd32ylW2FAM/B3DntoEwKxZuNYdQS
 5d7Novto/PZ00irlS1lKrBCr865+8KEIPOjXMjMOZ0LfUHL3WZ/6maWuYJx4yzU3yWf9CAHATHq
 hAwRXpn4YJdGVg2S1MazPz0JWQg7nx/IkpFYEAB/P1gqsSxWBcfgojjY1pKph7/VpzYcwyCdHus
 VwUisdQdt6RY4aihriKvLA21jZi/VSe2ytwr2CyST/4QQCNCQH0yYRmpduoyLsK+NAEOywH7+vi
 TlN7xMO3EHLK23mbozNsglj2XeslcOaZ4F4uiGpD/bXwRpLd+9ZD0UtFngeVgoWBlB4RIcEwK5j
 xlrGhb62PvzKByl/0WFL8xPdGspm3O+62+z60l+6/C13+5nRd5hDotLQHXaoFr5JBF052l110cH
 RI9IORIla4/SqLxBAVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38258-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rameshkumar.sundaram@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6126D6D69C5



On 6/29/2026 1:34 PM, Rameshkumar Sundaram wrote:
> On 6/17/2026 2:58 PM, Baochen Qiang wrote:
>> ath12k_peer_mlo_link_peers_delete() sends WMI peer_delete for every
>> link before waiting for any peer_unmap / peer_delete_resp event. The
>> shared per-radio completion ar->peer_delete_done could not
>> disambiguate which peer a response was for: every call to
>> ath12k_peer_delete_send() did
>> reinit_completion(&ar->peer_delete_done), so when an event for the
>> first link arrived between two sends it raised the count to 1 and
>> the second send promptly cleared it; the wait for the second link
>> then timed out with
>>
>>      Timeout in receiving peer delete response
>>
>> Replace the shared completion with a per-radio waiter list, with
>> each pending ath12k_peer_delete() caller queueing an
>> ath12k_peer_delete_wait carrying its (vdev_id, addr) and a private
>> struct completion. ath12k_peer_delete_resp_event() matches the
>> response against the list under ar->data_lock and signals the
>> matching waiter.
>>
>> Also correct the endian conversion in ath12k_peer_delete_resp_event()
>> logging, and add the missing \n in some logging.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
>>
>> Fixes: 8e6f8bc28603 ("wifi: ath12k: Add MLO station state change handling")
>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c |   2 +-
>>   drivers/net/wireless/ath/ath12k/core.h |   5 +-
>>   drivers/net/wireless/ath/ath12k/mac.c  |   2 +-
>>   drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
>>   drivers/net/wireless/ath/ath12k/peer.h |  19 ++++-
>>   drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
>>   6 files changed, 136 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/
>> core.c
>> index 742d4fd1b598..f71650039292 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
> 
> { ... }
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/
>> peer.h
>> index 49d89796bc46..3dc720a3dc12 100644
>> --- a/drivers/net/wireless/ath/ath12k/peer.h
>> +++ b/drivers/net/wireless/ath/ath12k/peer.h
>> @@ -9,13 +9,28 @@
>>     #include "dp_peer.h"
>>   +struct ath12k_peer_delete_wait {
>> +    struct list_head list;
>> +    u32 vdev_id;
>> +    u8 addr[ETH_ALEN];
>> +    struct completion done;
>> +};
>> +
>> +void ath12k_peer_delete_wait_register(struct ath12k *ar,
>> +                      struct ath12k_peer_delete_wait *wait,
>> +                      u32 vdev_id, const u8 *addr);
>> +void ath12k_peer_delete_wait_unregister(struct ath12k *ar,
>> +                    struct ath12k_peer_delete_wait *wait);
> 
> 
> The struct and functions appear to be used only within peer.c and are not referenced
> elsewhere. Could the function be made static in peer.c ?

Yeah, I can do that.

> 
>> +void ath12k_peer_delete_resp_signal(struct ath12k *ar, u32 vdev_id, const u8 *addr);
>> +void ath12k_peer_delete_wait_flush(struct ath12k *ar);
> 
> 
> -- 
> Ramesh


