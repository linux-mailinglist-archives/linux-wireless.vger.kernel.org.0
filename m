Return-Path: <linux-wireless+bounces-9854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD0923F79
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C841F23BF4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7C1B4C4B;
	Tue,  2 Jul 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEbYUpgt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402A38F83
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928176; cv=none; b=omPLedRVzJg2sQj7uPMTp8HOPDFKLk5GRsjXp/9SvXCUAMmHYhLbkrbPnQ4a2+4PCrrzOF+AR+8LDdD4DpFkQrhX9l7+mJfb0CtTHra7Fht67BqSvKqK1DRwXYwQ6Z226pUebjdqz5NsaZvPiUejvKuHIPbuCgfICeAZIhbtlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928176; c=relaxed/simple;
	bh=gKNKa0nlgIHI/MTbG7isQib7yZ9uA/afNheMP2daZjs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=r5mv7fvcQKlpuGgbDQmisRxCNTtxLZt33Mk2lfwxoB9WXw/3EORvWagCogUgWkj6YR2NtqK3zZ4Fi1hDkztdJKcGCvKR0iwkpvj5zgqHh9elxSuoeFfITHGEgE5FYiqhUxg0qdpSBCIruEY3ZG06VnIlIImfPBEI1uWewIzMlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEbYUpgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B419CC116B1;
	Tue,  2 Jul 2024 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719928175;
	bh=gKNKa0nlgIHI/MTbG7isQib7yZ9uA/afNheMP2daZjs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kEbYUpgt2TSZCzMjuxmAVcMzCmyaGHaCEAV+8xXcmfdcjB8vjW+R5InAghRQWE/vc
	 QKlzn4TYdysu1YMh4pc3xh04u7Hf4AXAZ2wynV5RPe1ZoKMVqgkZOhp3f9Awz/FY01
	 y0ta6P5dD4UN81bnpAL0DRM4Z66QTT/+KXzhSC6EVD6A0dR/+Qc2uUNDpqsWwQgN/K
	 eXGo9ZJdRn2OxWWws2SrW1o3YvGdTDIz3S1wn63MtoEqW2jG0PqoocBxJB0fQvDsr1
	 mPXcS2VPwzR5OMxZtb+uVDUGlD8gQeLNp2+aN6hZr2BUzOPgBFQp0DqUF/wtf25Jcd
	 Gn8Fl2TUPlLRA==
From: Kalle Valo <kvalo@kernel.org>
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] wifi: ath12k: add factory test mode support
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
	<20240624095305.37189-4-quic_aarasahu@quicinc.com>
Date: Tue, 02 Jul 2024 16:49:32 +0300
In-Reply-To: <20240624095305.37189-4-quic_aarasahu@quicinc.com> (Aaradhana
	Sahu's message of "Mon, 24 Jun 2024 15:23:04 +0530")
Message-ID: <87le2jgaz7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:

> Add support to process factory test mode commands(FTM) for calibration.
> By default firmware start with MISSION mode and to process the FTM commands
> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
> The pre-request is all the radios should be down before starting the test.
>
> All ath12k test mode interface related commands specified in enum
> ath_tm_cmd.
>
> When start command ATH_TM_CMD_TESTMODE_START is received, ar state
> is set to test Mode and FTM daemon sends test mode command to wifi
> driver via cfg80211. Wifi driver sends these command to firmware as
> wmi events. If it is segmented commands it will be broken down into
> multiple segments and encoded with TLV header else it is sent to
> firmware as it is.
>
> Firmware response via UTF events, wifi driver creates skb and send
> to cfg80211, cfg80211 sends firmware response to FTM daemon via
> netlink message.
>
> Command to boot in ftm mode
> insmod ath12k ftm_mode=1
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>

I have not reviewed this in detail yet but few first impressions:

> @@ -626,6 +634,8 @@ struct ath12k {
>  
>  	u32 freq_low;
>  	u32 freq_high;
> +	struct completion fw_mode_reset;
> +	u8 ftm_msgref;
>  };

fw_mode_reset is unused so I removed it in the pending branch.

> @@ -856,6 +867,8 @@ struct ath12k_base {
>  		/* protected by data_lock */
>  		u32 fw_crash_counter;
>  	} stats;
> +	bool ftm_segment_handler;
> +	struct ath12k_ftm_event_obj ftm_event_obj;
>  	u32 pktlog_defs_checksum;

ftm_segment_handler is also unused so removed that as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

