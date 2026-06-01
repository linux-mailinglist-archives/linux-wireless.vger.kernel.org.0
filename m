Return-Path: <linux-wireless+bounces-37251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFh+KZplHWqwaAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:57:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE761DF9B
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08744301F5CA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1D29D26E;
	Mon,  1 Jun 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvGYOIEi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WhqMDAty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD739A4BA
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311089; cv=none; b=Nz6PuK3zVA6L+0Q+doT9f2TBgl9/nIPDFyrdro/nXTu7EKoQwUxaejDumcJUgesxUJMGsY9yv4vVNDruFC84fXvmeep4A6rdzC4CqfmWIjz1Xs8SNJ7c8dCMzDr012eNFO7+G6zyKHz7TO+sIvrTRd7Ak6VJxZDLk/pZIpF/f70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311089; c=relaxed/simple;
	bh=20BUt6e17FWZlp/Kd3slCmh1bCT++SdAt9IdtES0ZTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUgdgotI0HjC0tYN5ZXA/5V50admzSIVTCHicGxnwXz65TQqj1FMAiePTM1pY13BGbswrt2x1buVWlIeKM10sOABXT3t/0jun/K8WbV/deETf+dTOr67YctR5YTo6A0CDLEI1/0oXj/nWwibvJzP3BL6rZ8w4kNwCdMMXO8yd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvGYOIEi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WhqMDAty; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fL2W1257999
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 10:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D+h4SeGoGOd+jPM+XZEcJJVnEtYDWfDIj8NINgO62jI=; b=ZvGYOIEiSr1V9fkU
	6bh4GcBfWepiUMiaqidMmTyGB/ItCK+pP6mijmV8bZ7cFNTsX/iZ2wj+8Xak/IOT
	mujdQB0EgxpSa6zOLhq8zzEjoylU2UOqF0w46ILhSS2NOg8lpOxlIQ991LHc3Oh/
	WeJH/UBWh1WfaUuhm8AulpS/h8lrPnVHKt3BVz0q5AOmnKWB7zf3a0B2UUDecmfL
	OQd1rqvaXoKt7SE8n7plwWdWQ+lUKuqMTM1hfV5tC5TBo6M3piZ6DkXxRx1C9o1b
	D4jhCaKjTOy8Wa7/2K1zXVnh3RLt/NameMfBu1ULsKO93lKm9+igBZJkT8FsbvPE
	JnInhg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6ssrh5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:51:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f24dcedso1644330b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780311087; x=1780915887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+h4SeGoGOd+jPM+XZEcJJVnEtYDWfDIj8NINgO62jI=;
        b=WhqMDAtyNU4dWii+Gfjyeptear1WhHh2IT7mQUcjmBFCclO65d4cHoLwIJjwWhiZnC
         h7vd09UhAdLpUOo+CCBbBIuwQwq8fGUcsIqxMNG17mWawqPTKmoo6QJzTv+MXOdX6UaD
         iftzkwnI2URuwMeRm7mybyGxybqAYeztKqepwI6e6O0uL5x5HxnZrljFFfXq9Q5gKjZt
         q2Np0vuYukMIlR2bV170l9DtNEIx85mN/ftscyl9VM2OwGrTgRKfaNg1vYrz5yWyDybM
         pAfqSC6OWAE9Myc1HnctWXPaIPWrQG7/E3DxOMI96GK28HWEj0voqTqHY+TkHLyXwq4J
         7BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311087; x=1780915887;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+h4SeGoGOd+jPM+XZEcJJVnEtYDWfDIj8NINgO62jI=;
        b=Jg1cbBx1ugwVO1wJc3BCUg+MUcL7FOi0MUdIRNmKAkA6v6dEjBkQVIYbt63ZI23mbI
         dr3UQAgHoeCPS/fHVLu5pCZUGT0QfM8XF/yHM5uVeZdWkxO7nTes+iQjdj85x/aVqQU4
         LSjHhz7fZfbCjujauPrm1z7dO+EjtEQ7KziKySzNlORsWKEDC9KxPZgjl3GEmt6r8ya6
         vMgOx116Y0yJN/H5z+Cdisp2ChN07pwaRmrhE7YEhyhp0oWPNBTedA9FOIb3ndxKR9ac
         Uo7ldgr98WXClYVAvnhXu3nigrSJ0B8zHqOWCqel58P33/OMYojNyUTiGXw54n+BdbMT
         w7NA==
X-Gm-Message-State: AOJu0YyoMeQQq/Kfej3oiVwfYhXheqxuKYHhffU9kfP7dPHyO/kh+Sbc
	aNg9ufR19BC23+urm2FxH41ax6Ckmhnkwu7vCvbTjEM5H+n4R3nepDnEEi+gqj8DTpA8j4maw3e
	bZP4BDVUizyazbd7O7bI6CsFNoQZPTCD5OP6Jw/P4T+/GYABeYQfWFyO0SeEqYyUrbJjOlQ==
X-Gm-Gg: Acq92OHQ6mY5pjJE2CpX0oVoxEOgQY8LRBy/qjxVp3pdo+QR/2M/qGtWfmOqZcHxkG1
	MirxS3yCigBqxPvzBQ+koRYwG5VlZ+0dQuoO7G59oifZsC8P8ZwOMEAuhwXZHWC96KTZKmLUvRc
	oDDQNtYMGhF1HcpPi+4yzjDKVmOyATBDoje8YlADx7a2vLteDj9Mp7W5Ds2oQ8HhTxPhhX0nsxR
	zijFdNfM2tEYXct+Mmp9KNC5LPxKxYZMhtp5EjdZpLdzZ2u3uGK3pmo8JLiZiuhHWvFhWB50PFF
	HXgoojX7CiYHhWeEHLMj+WGffAMciOuIk9bU+wBSeUNrKlhJW5KF+EyS++bcXFzB0Kiy2FJBr1N
	j1LjsuXsZsB0DmQNay84M3EmZ1tvZOukVcdhpexhyvDLnhCLEPnlYE4bNK81LmRLT0NWCihQUi7
	RKrgwleqeyHFNs4xKYoVYzTs0nVQoc
X-Received: by 2002:a05:6a21:7105:b0:3a2:d838:bfc6 with SMTP id adf61e73a8af0-3b42809f475mr10855571637.29.1780311086938;
        Mon, 01 Jun 2026 03:51:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:7105:b0:3a2:d838:bfc6 with SMTP id adf61e73a8af0-3b42809f475mr10855549637.29.1780311086485;
        Mon, 01 Jun 2026 03:51:26 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85861d5fe2sm7264726a12.8.2026.06.01.03.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 03:51:26 -0700 (PDT)
Message-ID: <4bc998d1-30a1-465d-b764-475a0a3e9b51@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 18:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent incorrect vif chanctx
 switch when handling multi-radio contexts
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
References: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522091828.3199584-1-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: y4d5m797h-07cyheKMJvdIcwzXVVSunY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwOCBTYWx0ZWRfX63xXJwLXTX0H
 U5b2GMKmzbg0CVPjj2L/8NQmURkhqwI6GdKDHQ5Y1FcRITbKWcUDioar6FlUyJNGrtKTkYkcNxR
 zrJ7mKVfM50AlxNFmkAeBwawWySZhAnacIdcNf23VEww511gqu0eSdfOxbkf79ZyuaAtGnRdhi1
 GxFXr5BUyrZNw2QtMLghanY+JECycjUaS5zPf5E0Hmqo6CzV++nsWfGbTVVbfQgt1//Isvb7Qv3
 htnPhs7YqI8GBc/JWGWHcy/4guxUnHgGtPUUwRm7YzNbwhCvUf7wdJDkFnfFkXMSY/sYy6hcUMW
 LGTA9cbL7L3m8K3wufeQu5/Pi66hi188iJO5GFlFNVNjMLxA7VZRBHwmtZnpUeLNSgiAiiMYJ2M
 gGYWJri+guXLlU3zv9eZQfKrjrmH1rAH91KpifqT64TmtLeCwr6ViIfgWH3tZlOLr19EmzrQwKn
 Oc1cF8lOH/Q7SKti1Zg==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1d642f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8GVvVDYDP2p1e3aVpqAA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: y4d5m797h-07cyheKMJvdIcwzXVVSunY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010108
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37251-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09EE761DF9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/22/2026 5:18 PM, Maharaja Kennadyrajan wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> 
> When multiple links switch channel contexts around the same time, mac80211
> may complete CSA for several links together and invoke
> ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
> one underlying radio in a single-wiphy configuration.
> 
> The driver currently assumes that all entries in the vifs array belong to the
> same radio and derives the radio context from the first element. On multi-radio
> hardware, this can lead to incorrect vdev selection/updates and may corrupt
> driver state when the number of vifs exceeds what a single radio supports.
> 
> Fix this by validating each vif's switch request and then processing vifs
> grouped by their associated radio. For each vif, ensure the band does not
> change across the switch and that both old/new channel contexts resolve to a
> valid ath12k device. Reject attempts to move a vif between radios (not
> supported for now) and return -EOPNOTSUPP to upper layers.
> 
> Then, iterate through the input vifs, collect all unprocessed entries that map
> to the same radio, and invoke ath12k_mac_update_vif_chan() separately for each
> radio group. This removes any reliance on mac80211 providing the array grouped
> by radio or sharing old_ctx pointers across vifs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
> Co-developed-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
> Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


