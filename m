Return-Path: <linux-wireless+bounces-9930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACC59262B4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D97B1F24311
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4A17A599;
	Wed,  3 Jul 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuauIKrG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8917A59A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015062; cv=none; b=H22LySAnwT8mya0nj4mEIj2Xv6pSiTmv5mJxgmqRz/PfO+6LY6tcxNYLAw8hJ9jsv3S3RGErDnYpHVEbMNz39wMs43yd2XHgtvk4b+fxUgyodpL1kN8ZhiMD6KVxvUDMjVZuIZI1W4e041eC9xF5PCQiGR/51qYVX2ijf0bnP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015062; c=relaxed/simple;
	bh=0ghaEkln6muWfC3OI81no2MWCwPisboChG+ZgTv+5GY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=eLMGsWNKsYwXuzQI9IpwI2LSahk5FDmI7vu8E/81QzHC1s8cRtcrVkmozL9fN+/i7sDHLCCXE97iNAnZm7sYO7b/vkvRJuZowGofhUhkT3W8dOB3nF96M8dSqSqO/wssg7sNmelFvaYu2e0EX7IbDZ5lcUPuEqlcHTUVITDW6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuauIKrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36ABC2BD10;
	Wed,  3 Jul 2024 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720015061;
	bh=0ghaEkln6muWfC3OI81no2MWCwPisboChG+ZgTv+5GY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=RuauIKrGtL3QwP+hft0nomDS/ic+9Y4AFfMW0vgfjnVF3DGiY1QpQfEJs+Gl8r1C3
	 8Q3IL4RlW1QS6021izmkr08dRqXBWKH0w36slu4onjSLV/TvgbQdZgZN2162wEtB3x
	 xNLVIOxxXg13s1qo2YDsQMey3jqbTWliRsCS5qnywUo2B2/PgguJYVxHVg2ynkcb7W
	 InDnXORbQzku7sJ1isWn3eYL4Olksqv0MpfSPe3PSRUzoffn+8ObBF52WeAbqjLpn0
	 7NO6AYN4ymnrZvGWfcTUclpQibamNDNs7io1MGERJ/BvVXWSl6rrjuryQ0k8v0g8dJ
	 X353rxOyqAmog==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-next-20240702
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
References: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
 <quic_jjohnson@quicinc.com>, <quic_kvalo@quicinc.com>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172001505815.3343449.10854537825180902753.kvalo@kernel.org>
Date: Wed,  3 Jul 2024 13:57:39 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The following changes since commit bb678f01804ccaa861b012b2b9426d69673d8a84:
> 
>   Merge branch 'intel-wired-lan-driver-updates-2024-06-03' (2024-06-10 19:52:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240702
> 
> for you to fetch changes up to 5344fc76f8944249026884157f846f88489edfc0:
> 
>   wifi: ath12k: Support TQM stats (2024-07-01 21:57:28 +0300)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.11
> 
> We have moved to a new group-managed repo, and this is the first pull
> request from that repo, and from me. Fingers crossed...
> 
> We have some new features in ath12k along with some cleanups in ath11k
> and ath12k. Also notable are some device-tree changes to allow certain
> ath11k and ath12k devices to work with a new power sequencing
> subsystem.
> 
> Major changes:
> 
> ath12k
> 
> * DebugFS support for datapath statistics
> * WCN7850: support for WoW (Wake on WLAN)
> * WCN7850: device-tree bindings
> 
> ath11k
> 
> * QCA6390: device-tree bindings
> 
> ----------------------------------------------------------------
> Aaradhana Sahu (3):
>       wifi: ath12k: Fix WARN_ON during firmware crash in split-phy
>       wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
>       wifi: ath12k: fix uninitialize symbol error on ath12k_peer_assoc_h_he()
> 
> Aditya Kumar Singh (3):
>       wifi: ath12k: fix per pdev debugfs registration
>       wifi: ath12k: unregister per pdev debugfs
>       wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry
> 
> Ajith C (1):
>       wifi: ath12k: fix firmware crash due to invalid peer nss
> 
> Baochen Qiang (11):
>       wifi: ath12k: fix ACPI warning when resume
>       wifi: ath11k: fix RCU documentation in ath11k_mac_op_ipv6_changed()
>       wifi: ath11k: fix wrong handling of CCMP256 and GCMP ciphers
>       wifi: ath12k: add ATH12K_DBG_WOW log level
>       wifi: ath12k: implement WoW enable and wakeup commands
>       wifi: ath12k: add basic WoW functionalities
>       wifi: ath12k: add WoW net-detect functionality
>       wifi: ath12k: implement hardware data filter
>       wifi: ath12k: support ARP and NS offload
>       wifi: ath12k: support GTK rekey offload
>       wifi: ath12k: handle keepalive during WoWLAN suspend and resume
> 
> Bartosz Golaszewski (2):
>       dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
>       dt-bindings: net: wireless: describe the ath12k PCI module
> 
> Dinesh Karthikeyan (6):
>       wifi: ath12k: Add support to enable debugfs_htt_stats
>       wifi: ath12k: Add htt_stats_dump file ops support
>       wifi: ath12k: Add support to parse requested stats_type
>       wifi: ath12k: Support Transmit Scheduler stats
>       wifi: ath12k: Support pdev error stats
>       wifi: ath12k: Support TQM stats
> 
> Harshitha Prem (1):
>       wifi: ath12k: Remove unused ath12k_base from ath12k_hw
> 
> Karthikeyan Periyasamy (3):
>       wifi: ath12k: avoid unnecessary MSDU drop in the Rx error process
>       wifi: ath12k: fix mbssid max interface advertisement
>       wifi: ath12k: fix peer metadata parsing
> 
> Lingbo Kong (3):
>       wifi: ath11k: fix ack signal strength calculation
>       wifi: ath11k: modify the calculation of the average signal strength in station mode
>       wifi: ath12k: Fix pdev id sent to firmware for single phy devices
> 
> Pradeep Kumar Chitrapu (1):
>       wifi: ath12k: fix legacy peer association due to missing HT or 6 GHz capabilities
> 
> Rameshkumar Sundaram (2):
>       wifi: ath12k: modify remain on channel for single wiphy
>       wifi: ath12k: fix driver initialization for WoW unsupported devices
> 
> Ramya Gnanasekar (1):
>       wifi: ath12k: Dump additional Tx PDEV HTT stats
> 
> Wolfram Sang (1):
>       wifi: ath11k: use 'time_left' variable with wait_event_timeout()
> 
>  .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   46 +
>  .../bindings/net/wireless/qcom,ath12k.yaml         |   99 ++
>  drivers/net/wireless/ath/ath11k/dp_rx.c            |    3 +-
>  drivers/net/wireless/ath/ath11k/dp_rx.h            |    3 +
>  drivers/net/wireless/ath/ath11k/dp_tx.c            |   16 +-
>  drivers/net/wireless/ath/ath11k/dp_tx.h            |    4 +-
>  drivers/net/wireless/ath/ath11k/hal_tx.h           |    4 +-
>  drivers/net/wireless/ath/ath11k/mac.c              |   29 +-
>  drivers/net/wireless/ath/ath11k/qmi.c              |   20 +-
>  drivers/net/wireless/ath/ath12k/Makefile           |    3 +-
>  drivers/net/wireless/ath/ath12k/acpi.c             |    2 +
>  drivers/net/wireless/ath/ath12k/core.c             |   71 +-
>  drivers/net/wireless/ath/ath12k/core.h             |   34 +-
>  drivers/net/wireless/ath/ath12k/debug.h            |    3 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c          |   19 +-
>  drivers/net/wireless/ath/ath12k/debugfs.h          |    6 +-
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.c    | 1540 ++++++++++++++++++++
>  .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  567 +++++++
>  drivers/net/wireless/ath/ath12k/dp.h               |    1 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c            |   54 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h            |    4 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c            |    4 +-
>  drivers/net/wireless/ath/ath12k/hal_desc.h         |   26 +-
>  drivers/net/wireless/ath/ath12k/htc.c              |    6 +
>  drivers/net/wireless/ath/ath12k/hw.h               |    2 -
>  drivers/net/wireless/ath/ath12k/mac.c              |  302 +++-
>  drivers/net/wireless/ath/ath12k/mac.h              |    5 +
>  drivers/net/wireless/ath/ath12k/wmi.c              |  728 ++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h              |  586 +++++++-
>  drivers/net/wireless/ath/ath12k/wow.c              | 1026 +++++++++++++
>  drivers/net/wireless/ath/ath12k/wow.h              |   62 +
>  31 files changed, 5156 insertions(+), 119 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wow.h

Pulled, thanks.

c1cacb01f355 Merge tag 'ath-next-20240702' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


