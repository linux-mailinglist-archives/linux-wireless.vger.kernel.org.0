Return-Path: <linux-wireless+bounces-36348-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GAnBj6zA2rt9AEAu9opvQ
	(envelope-from <linux-wireless+bounces-36348-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 01:09:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7A52B333
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCA6305117C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 23:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5503A383E;
	Tue, 12 May 2026 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dADzSW6U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e9hGjmX/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2E39BFF5
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627387; cv=none; b=NwTm6FHohReLkETf+2Y+EDoJ01Hl019Liz5aHH4MDaPC32DXnOlkg6UjU61FuI2nNi3ADaaQjGAoPlaydTDCxLgJQb03EjL54waePkyngx322qhNyXgqZb7dG7vwWwadi3CG94P4f6etMKlhyixk1Zl41T7mE7oDgDXGsbXUNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627387; c=relaxed/simple;
	bh=JdTLJVnpeI//7Q3zUIMvt+lU/ziOxzJPxGpjFI6WPdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcII6SQeQj5/TNm2fZVH9u+8m+KuJdE5GHW8svUuu7Lu3La3nTMC6WTddm22y8QkiR6T5Brb90emW2FfW6FbCzLgA9ek98OzC6JlVNAgJCr2AUQ3Zh/v1AmM78Hiv8mqblRqmGZkJdWYqWskDaQWQOgYOAipMpTz33f/Uewy//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dADzSW6U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9hGjmX/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CLmXBb1432957
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+iFRSuQ7UV7VaBz7cxLx0+Ht3vKhhgSju6olGQmM5Jc=; b=dADzSW6UaBFuDFi5
	xO4fszBtP+/JBqYczFZbyYPP4BCAjoxSvPXD9ZmoYC9uw31mM2bi04bAAxO8yI1L
	WRww2SHi7xv0X79Ohy2KiCrMWiiESo69V2xWqvB1vRnzGIJgZqg+8JqYsei7nBfD
	L0tcMnZcKrWt2vnUSjtrpiN+YwUDgH2GEZmsZ4usdRc0NiNubTxZbB6Brn5asz+j
	LBrfA6xoxnzL92oZF8+ZdqUCHPLApvJWUxBTf22rNLkbGRa53mm7E0CP3Ax6ULUA
	Rv8KJxzuw5Ii6KOCds+Am4mW82iq/I1fplic4hDYJ1VacJFl9h7H0y8bJlSf3ZM9
	INPZOQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx8sn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:09:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so9858928eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778627383; x=1779232183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+iFRSuQ7UV7VaBz7cxLx0+Ht3vKhhgSju6olGQmM5Jc=;
        b=e9hGjmX/uIwHnbTBFBWN91XMTUL5uS0GsKzaLoDbY+M9uMAkZKAL8R6eU5G6uKorO8
         99duls+4QqEF71XTKTftfi9P+JFiqh/uizggchJz17zYEAErYTLe73OLFyqe8E0AR3BQ
         D6EVB9CooyIdXe57IuczIt7kSTn7a208Xe4capW5+PgGTgRFyrdjcg8K5SnTJMisW1Zk
         bcxwGU7npkMdgB3NUTBPqVCIB3k2FjpjfEdoGyKUq+hgp6gb8mpgUThSzdAuZcC606Q5
         ir6a+KaBDlTwqaPiOpk1+HmAQRRBAojxHI/dvpFIsESHO3+fTeCtf2S/4vVn9T8iHkF7
         d0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627383; x=1779232183;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iFRSuQ7UV7VaBz7cxLx0+Ht3vKhhgSju6olGQmM5Jc=;
        b=FZzMZBBcYxAVbr6aBCigpG4S6DPO10NbUkTSqJyTmGv1Z9A5pcvHuzoJchQJFflWV1
         tiR5JEUGKqK1wnIHUtQ+D+3nYgaWxLDvFXI0jtcSTFgOtRykz9/iehnW9nvZE19tcHSj
         sieNLuEyz4fq7Kck78Rji3lFxhtBput6bZ9MgRpkmgt0UsMaaC/2QoVhqMHofo+61lce
         Nq5UcZd7QkDnUCe+RHZVcMAKqLAHMNr5vGRyiEDLeWJEzJI1ISFtL8GOjW0CyecxVqJd
         mDwBFEC6u66XCsceYOyqQl4JdKiViR6iN3CRzh9HEOOzBLK93AKBmTzdExm0JYRF4a5w
         6kbg==
X-Gm-Message-State: AOJu0YyGzEWg9h11vAAOzeFwwvOVFFRN69OvZ3G+Cn6YDsjuhu5aooFM
	KeTLd8uxzhWHN4/kImL2O6xvl6wOv5AuDiDjvbyeq4kZadU42vcvpm51qWHm2lxH0IyWAspc3Kh
	oaV4YDrKkD9sRA33wL+YyS84HlI8/l0T9VEeEHh6zhYVI15WYgZf6JbmpIWyFH3WQlMV5gw==
X-Gm-Gg: Acq92OFoCjNIpYMn6J4U+X7m7BJknq7iltL0Bl3qryIxDRfgGcLgOKheOaVwOnvjpGW
	JwAfEVtfhG+HR8+Xen7qFJt3mIv9T3biEyyINXcz3cbKh9gBc3KSWiGMGT6LYKdhgngc6YPxJTS
	S07Zl3ywC9O6ZZrZSYY1YnjLrzpVF3/d5+ruSKjeuln3C594YoYzvmUGJSu6eZmNkddtR9KA8aT
	qDvqIN6fcEok0F/xBNs4LBGSJ3pt0jbkMaG2vDL5ZqmX77kcnHNxOE1Exrofh9I4K48TEX6RVmG
	M0cT9HafKKOVw4yb6fyzFxR5jbYQql8ypQfL2XmQXwqm9pYpmPVyJV0LaIB8b9qXYHW2TGklScE
	z5Mp34/EsOuR3/12iSS840jyd7z4id042AvPguUD3yZPqWaYI4QeWsBf3ttTlRf/f9D83sR8iZ7
	tsbUlB19Jsz4fMCA==
X-Received: by 2002:a05:7301:5807:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-301556537d9mr140559eec.18.1778627383338;
        Tue, 12 May 2026 16:09:43 -0700 (PDT)
X-Received: by 2002:a05:7301:5807:b0:2d2:129a:1694 with SMTP id 5a478bee46e88-301556537d9mr140532eec.18.1778627382674;
        Tue, 12 May 2026 16:09:42 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm19636171eec.26.2026.05.12.16.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 16:09:42 -0700 (PDT)
Message-ID: <e9a822df-f0e1-464b-af99-c1ca315ec5cf@oss.qualcomm.com>
Date: Tue, 12 May 2026 16:09:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND RFC 1/3] net: ath11k: fix redundant reset from
 stale pending workqueue bit
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
 <20260330-ath11k-lockup-fixes-v1-1-7ed21095c2c4@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330-ath11k-lockup-fixes-v1-1-7ed21095c2c4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mjcSTOlodvzxoH_weKIXOsqRYeIcdhEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIzNyBTYWx0ZWRfX1bB71gpxkhjY
 vgN+A3p7ZsyYzlXQbye2b8uTbQ0xcKsGR/fSlA8xQYZ9XS7UPnloDQoWro79dpouymidWmWYv57
 YeTnJwnmiMhvKeG2jD1eaZhWDpmh4MTb1cd7RO8WbSys0pTL/jDxYeib95sB66p9cpk9sU/MEBK
 GAplEbwJlZtldVd4zbqr6ria0q+tE9AjCr6uRxrrNipCl8afEpnhdzQQBDLQp+OVmlbUVl5MhIj
 RRv30iyXpXz2ou2wC7J9Xed680MRmd/u1cweS0XA2c8eEm8sIU/CYXucG+dBOFncc/oNehlRhKX
 AZMSQemwBaGTimPIsCfUEsZuJ3qLqVvDqFBak1duzO+saK0IQG8Wz3i2DmWsfeB96ksvRadTG7r
 ouIaQje9tOrzhVyX8L3dfFQjH8PN1h5GHNn20OQ0JhodbPhtR9qqdpzIjnK1zmPof/rQPDN3CJA
 ZUTrjTTnkOUfL6qYVhg==
X-Proofpoint-GUID: mjcSTOlodvzxoH_weKIXOsqRYeIcdhEz
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a03b338 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QX4gbG5DAAAA:8 a=xtXBsnOKPzI8Tx_VA0wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120237
X-Rspamd-Queue-Id: 6AA7A52B333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36348-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
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

On 3/30/2026 3:05 AM, Matthew Leach wrote:
> During a firmware lockup, WMI commands time out in rapid succession,
> each calling queue_work() to schedule ath11k_core_reset().  This can
> cause a spurious extra reset after recovery completes:
> 
> 1. First WMI timeout calls queue_work(), sets the pending bit and
>    schedules ath11k_core_reset(). The workqueue clears the pending bit
>    before invoking the work function. reset_count becomes 1 and the reset
>    is kicked off asynchronously. ath11k_core_reset() returns.
> 
> 2. Second WMI timeout calls queue_work() and re-queues the work. When it
>    runs after step 1 returns, it sees reset_count > 1 and blocks in
>    wait_for_completion(). The pending bit is again cleared.
> 
> 3. Third WMI timeout calls queue_work(), the pending bit was cleared in
>    step 2, so this succeeds and arms another execution.
> 
> 4. The asynchronous reset finishes. ath11k_mac_op_reconfig_complete()
>    decrements reset_count and calls complete(). The blocked worker from
>    step 2 wakes, takes the early-exit path, and decrements reset_count to
>    0.
> 
> 5. The workqueue sees the pending bit from step 3 and runs
>    ath11k_core_reset() again. reset_count is 0, triggering a
>    full redundant hardware reset.
> 
> Fix this by calling cancel_work() on reset_work in
> ath11k_mac_op_reconfig_complete() before signalling completion. This
> clears any stale pending bit, preventing the spurious re-execution.
> 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index e4ee2ba1f669..748f779b3d1b 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -9274,6 +9274,10 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>  			 * the recovery has to be done for each radio
>  			 */
>  			if (recovery_count == ab->num_radios) {
> +				/* Cancel any pending work, preventing a second redudant

nits:
1) networking no longer uses a different block comment style so use the
standard style where /* is on a line by itself
2: s/redudant/redundant/ (subject has it right)

but don't post a new version just for these -- wait for any other comments.
I'm pinging the development team to look at this thread.

> +				 * reset.
> +				 */
> +				cancel_work(&ab->reset_work);
>  				atomic_dec(&ab->reset_count);
>  				complete(&ab->reset_complete);
>  				ab->is_reset = false;
> 


