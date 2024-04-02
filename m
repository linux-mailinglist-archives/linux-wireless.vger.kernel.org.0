Return-Path: <linux-wireless+bounces-5756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF68895B99
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F46E287B3A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0715AD8A;
	Tue,  2 Apr 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxncrdBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603115AD89
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082044; cv=none; b=WYoGEqAMUT78QNC9su8tep5MeXlvG0fIrAHnZFvCyrZ0Di5Bsk7Oluf3HdSsgJbxw7SRofNNVhKirF+BS7LqdIT1MZ040Q0a5uaKPQbSTiMDLBDNM9JMz1Y+XjHGrFVMBXZTJZty3M7cYV7NqbwwPolGNp5CmjIDGoNbrqtAZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082044; c=relaxed/simple;
	bh=AphPWF0A6DVidB63NIiJ3E2oevs+O6X/lp7L6gFJYkU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Qy2IJuLYLFGaDJKXR/73UWmukUkXE1QYIa6oaCfgrlw4B/F7QDkBpgoYoeuaYG46OAtDUhJA7qvzuNizgIyyBJTCvlg6yYappFaSOGFX2WP2X4CbMHFiSTvhLI13fg6rY4JiEievrForJxhg38Ba7G2Mt1krdz99I0yabybnEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxncrdBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E6C433C7;
	Tue,  2 Apr 2024 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082043;
	bh=AphPWF0A6DVidB63NIiJ3E2oevs+O6X/lp7L6gFJYkU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lxncrdBY8WYuU5d26UN/w5OJ5dy0muMsh/gWywMZ93WRpCLl1jeNFjT8IAs6T8SFD
	 osrd3YvlEF/HpC8Rz1hxzxah/RIVqptvT/zOZ5/uDKycMjPJiMwYhAN8Rbehqc72BE
	 2+jRiSaYYFlRhTopYFCOF2UhZF8Q4oI30SDCPwE/m0tfredsnS9vxisT8a/4fJyvZl
	 bqwoe91KdPmYfI6dmJG+GZHakXX9NDATHsdG4Gas+U4S3ASkngbw5FgMF9ymOTz8+j
	 GlmvPUHK2TSuQehMrqvWHhY63H2izZ64EYjeMtFk6IwvOxFNsN0McZB8mSMZTRFJPN
	 1/v+OK8qDb5Lw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-next-20240402
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <87sf0366j6.fsf@kernel.org>
References: <87sf0366j6.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171208204081.790352.4396441740949174938.kvalo@kernel.org>
Date: Tue,  2 Apr 2024 18:20:42 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
> 
> Please pull, more information in the tag below.
> 
> Kalle
> 
> 
> The following changes since commit f654e228ed6b822e87e6e6ad8e889bedccae2e16:
> 
>   Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-03-05 20:57:28 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240402
> 
> for you to fetch changes up to f09e3b774fe806ee0b1f2bb69771e8c29961e40a:
> 
>   wifi: ath9k: eeprom: fix sparse endian warnings (2024-03-25 12:51:37 +0200)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.10
> 
> ath drivers now have no remaining sparse warnings, otherwise smaller
> fixes and some refactoring.
> 
> ath11k
> 
> * P2P support for QCA6390, WCN6855 and QCA2066
> 
> ----------------------------------------------------------------
> Aloka Dixit (1):
>       wifi: ath12k: use correct flag field for 320 MHz channels
> 
> Baochen Qiang (3):
>       wifi: ath10k: poll service ready message before failing
>       wifi: ath11k: don't force enable power save on non-running vdevs
>       wifi: ath11k: do not process consecutive RDDM event
> 
> Jeff Johnson (3):
>       wifi: ath12k: remove obsolete struct wmi_start_scan_arg
>       wifi: ath11k: remove obsolete struct wmi_start_scan_arg
>       wifi: ath11k: fix soc_dp_stats debugfs file permission
> 
> Kalle Valo (7):
>       wifi: ath6kl: fix sparse warnings
>       wifi: wcn36xx: buff_to_be(): fix sparse warnings
>       wifi: wcn36xx: main: fix sparse warnings
>       wifi: wil6210: fix sparse warnings
>       wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
>       wifi: ath9k: fix ath9k_use_msi declaration
>       wifi: ath9k: eeprom: fix sparse endian warnings
> 
> Kang Yang (8):
>       wifi: ath11k: change interface combination for P2P mode
>       wifi: ath11k: add P2P IE in beacon template
>       wifi: ath11k: implement handling of P2P NoA event
>       wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>       wifi: ath11k: change scan flag scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
>       wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
>       wifi: ath12k: remove duplicate definitions in wmi.h
>       wifi: ath11k: remove duplicate definitions in wmi.h
> 
> Karthikeyan Periyasamy (3):
>       wifi: ath12k: Refactor Rxdma buffer replinish argument
>       wifi: ath12k: Optimize the lock contention of used list in Rx data path
>       wifi: ath12k: Refactor error handler of Rxdma replenish
> 
> Kevin Lo (1):
>       wifi: ath11k: adjust a comment to reflect reality
> 
> Li Zhijian (1):
>       wifi: ath: Convert sprintf/snprintf to sysfs_emit
> 
> Thiraviyam Mariyappan (1):
>       wifi: ath12k: fix desc address calculation in wbm tx completion
> 
>  drivers/net/wireless/ath/ath10k/thermal.c    |   2 +-
>  drivers/net/wireless/ath/ath10k/wmi.c        |  26 +++-
>  drivers/net/wireless/ath/ath11k/Makefile     |   3 +-
>  drivers/net/wireless/ath/ath11k/core.c       |  20 ++-
>  drivers/net/wireless/ath/ath11k/debugfs.c    |   4 +-
>  drivers/net/wireless/ath/ath11k/mac.c        | 175 +++++++++++++++++++++------
>  drivers/net/wireless/ath/ath11k/mhi.c        |  17 ++-
>  drivers/net/wireless/ath/ath11k/p2p.c        | 149 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/p2p.h        |  22 ++++
>  drivers/net/wireless/ath/ath11k/pci.h        |   1 +
>  drivers/net/wireless/ath/ath11k/thermal.c    |   2 +-
>  drivers/net/wireless/ath/ath11k/wmi.c        | 107 +++++++++++++++-
>  drivers/net/wireless/ath/ath11k/wmi.h        |  78 ++++++------
>  drivers/net/wireless/ath/ath12k/dp.c         |  31 +++--
>  drivers/net/wireless/ath/ath12k/dp.h         |   7 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c      | 140 +++++++++++++--------
>  drivers/net/wireless/ath/ath12k/dp_rx.h      |   1 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c      |   2 +-
>  drivers/net/wireless/ath/ath12k/wmi.c        |   2 +-
>  drivers/net/wireless/ath/ath12k/wmi.h        |  34 ------
>  drivers/net/wireless/ath/ath6kl/htc_mbox.c   |   3 +-
>  drivers/net/wireless/ath/ath6kl/htc_pipe.c   |   3 +-
>  drivers/net/wireless/ath/ath9k/ath9k.h       |   1 +
>  drivers/net/wireless/ath/ath9k/eeprom_4k.c   |   2 +-
>  drivers/net/wireless/ath/ath9k/eeprom_9287.c |   4 +-
>  drivers/net/wireless/ath/ath9k/eeprom_def.c  |   6 +-
>  drivers/net/wireless/ath/ath9k/pci.c         |   2 -
>  drivers/net/wireless/ath/ath9k/xmit.c        |  10 +-
>  drivers/net/wireless/ath/wcn36xx/main.c      |   4 +-
>  drivers/net/wireless/ath/wcn36xx/txrx.c      |   4 +-
>  drivers/net/wireless/ath/wcn36xx/wcn36xx.h   |   7 +-
>  drivers/net/wireless/ath/wil6210/cfg80211.c  |   4 +-
>  drivers/net/wireless/ath/wil6210/fw.h        |   1 -
>  drivers/net/wireless/ath/wil6210/fw_inc.c    |   4 +-
>  34 files changed, 660 insertions(+), 218 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
>  create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h

Pulled, thanks.

0ccf50df61f9 Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/87sf0366j6.fsf@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


