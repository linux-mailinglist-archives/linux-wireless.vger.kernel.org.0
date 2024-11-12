Return-Path: <linux-wireless+bounces-15209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BF9C5C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4EF284150
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D120262A;
	Tue, 12 Nov 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWKk+5gK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6859202628
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426656; cv=none; b=bmoL9Upz7g4sHTzeho6VKwZXXIP4Jlc3VmqTE3iNEWXpVC2OHrgdIQQElzvvBcXuJSChmNiZV8tu0c55Ty5iHNwptLnBbrFe/mnk5U5nQHfD5+e6r2+ClyjC5yMRUymhPG9kB6r5kXZEm6Qtb7ai2nBzUVjZ/OFGRARIYMKI+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426656; c=relaxed/simple;
	bh=hRPj4clhocGqNEn4CH8MQoODgrwCA8SvKrYXdlNXTwk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=V+xXpdovFSasjYon63E7DojnaoU0x62huH8Opr8EJmhBT0rqaHKdRPXYcsVLdQFJuEsWcKPvk4vnD97X1cqUdPP8bqwwiEd0aGtoty1+eJirBqoWO3KeblFqsC5kSPLO4wR3Y/Rk7WfCC/fpOuxHgohDjwrYVQEqFl92QrJM5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWKk+5gK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34632C4CECD;
	Tue, 12 Nov 2024 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426656;
	bh=hRPj4clhocGqNEn4CH8MQoODgrwCA8SvKrYXdlNXTwk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KWKk+5gKig31WFZ6Hw7DUmWDBYQAx7w+WvUP47uBAUeq4l4pYaQQxmj38GfJ8D6vk
	 hpmk+7MJ7a16+VA7PHVahCXFp4B5mFMXvFJ4OXetGrImvPlDtcKPhrk2FLe0zCw/q6
	 ixvPNygJNpVXq4m343XQmrC5upU7ckWV5w4J9O4r2w9/heNfzYuxPDuf11K2Lcfma+
	 iNaZekG9oss26XuEM+xOCZE1NDZuPZPX+bBvyOiutzGIAQndA5bPgOnF91NAkrrmqh
	 AGZ3jyrUdypJ0E2agwXam92xOan7OixdF1aj++dEeoaRtq5syRLQF8RNr1qd2RZQy+
	 Dznx8ST8uUEKQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v4 1/4] wifi: ath12k: Support Downlink Pager Stats
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
	<20241106044548.3530128-2-quic_rdevanat@quicinc.com>
Date: Tue, 12 Nov 2024 17:50:53 +0200
In-Reply-To: <20241106044548.3530128-2-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Wed, 6 Nov 2024 10:15:45 +0530")
Message-ID: <87frnw4fj6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add support to request downlink pager stats from firmware through HTT
> stats type 36. These stats give paging information like number of pages,
> their timestamp, number of locked and free pages, synchronous and
> asynchronous locked pages.
>
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 responds to
> the event requesting stats, but it does not give any data.
>
> Sample output:
> -------------
> echo 36 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_DLPAGER_STATS_TLV:
> ASYNC locked pages = 2
> SYNC locked pages = 0
> Total locked pages = 2
> Total free pages = 127
>
> LOCKED PAGES HISTORY
> last_locked_page_idx = 0
> Index - 0 ; Page Number - 8495 ; Num of pages - 1 ; Timestamp - 4031009360us
> Index - 1 ; Page Number - 7219 ; Num of pages - 2 ; Timestamp - 885379515us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
> UNLOCKED PAGES HISTORY
> last_unlocked_page_idx = 0
> Index - 0 ; Page Number - 7144 ; Num of pages - 2 ; Timestamp - 4032070008us
> Index - 1 ; Page Number - 7214 ; Num of pages - 2 ; Timestamp - 885379512us
> Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
> .....
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

[...]

> +static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
> +					   int idx, char *str_buf)
> +{
> +	u32 ts_lo;
> +	u32 ts_hi;
> +	u64 page_timestamp;
> +	u16 index = 0;

Nitpicking but please strive for reverse xmas style and no need to have
just one variable per line:

        u64 page_timestamp;
        u32 ts_lo, ts_hi;
        u16 index = 0;

> +static void
> +ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
> +				   struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_dl_pager_stats_tlv *stat_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 info0;
> +	u32 info1;
> +	u32 info2;
> +	u32 dword_lock;
> +	u32 dword_unlock;
> +	u8 pg_locked;
> +	u8 pg_unlock;
> +	int i;
> +	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {0};

Same here. And maybe initialise buf_len separately to keep the
declarations clean?


> +	if (tag_len < sizeof(*stat_buf))
> +		return;
> +
> +	info0 = le32_to_cpu(stat_buf->info0);
> +	info1 = le32_to_cpu(stat_buf->info1);
> +	info2 = le32_to_cpu(stat_buf->info2);
> +	dword_lock = u32_get_bits(info2, ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO2);
> +	dword_unlock = u32_get_bits(info2, ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO2);

There's le32_get_bits() so you can simplify this function quite a lot.

> +	pg_locked = ATH12K_HTT_STATS_PAGE_LOCKED;
> +	pg_unlock = ATH12K_HTT_STATS_PAGE_UNLOCKED;
> +
> +	len += scnprintf(buf + len, buf_len - len, "HTT_DLPAGER_STATS_TLV:\n");
> +	len += scnprintf(buf + len, buf_len - len, "ASYNC locked pages = %u\n",
> +			 u32_get_bits(info0, ATH12K_HTT_DLPAGER_ASYNC_LOCK_PG_CNT_INFO0));
> +	len += scnprintf(buf + len, buf_len - len, "SYNC locked pages = %u\n",
> +			 u32_get_bits(info0, ATH12K_HTT_DLPAGER_SYNC_LOCK_PG_CNT_INFO0));
> +	len += scnprintf(buf + len, buf_len - len, "Total locked pages = %u\n",
> +			 u32_get_bits(info1, ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO1));
> +	len += scnprintf(buf + len, buf_len - len, "Total free pages = %u\n",
> +			 u32_get_bits(info1, ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO1));
> +
> +	len += scnprintf(buf + len, buf_len - len, "\nLOCKED PAGES HISTORY\n");
> +	len += scnprintf(buf + len, buf_len - len, "last_locked_page_idx = %u\n",
> +			 dword_lock ? dword_lock - 1 : (ATH12K_PAGER_MAX - 1));
> +	for (i = 0; i < ATH12K_PAGER_MAX; i++) {

Empty line before for.

> +		memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
> +		ath12k_htt_print_dlpager_entry(&stat_buf->pgs_info[pg_locked][i],
> +					       i, str_buf);
> +		len += scnprintf(buf + len, buf_len - len, "%s", str_buf);
> +	}
> +
> +	len += scnprintf(buf + len, buf_len - len, "\nUNLOCKED PAGES HISTORY\n");
> +	len += scnprintf(buf + len, buf_len - len, "last_unlocked_page_idx = %u\n",
> +			 dword_unlock ? dword_unlock - 1 : ATH12K_PAGER_MAX - 1);
> +	for (i = 0; i < ATH12K_PAGER_MAX; i++) {

Empty line before for.

> +		memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
> +		ath12k_htt_print_dlpager_entry(&stat_buf->pgs_info[pg_unlock][i],
> +					       i, str_buf);
> +		len += scnprintf(buf + len, buf_len - len, "%s", str_buf);
> +	}
> +	len += scnprintf(buf + len, buf_len - len, "\n");

Empty line after '}'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

