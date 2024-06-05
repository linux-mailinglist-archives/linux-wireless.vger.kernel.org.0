Return-Path: <linux-wireless+bounces-8575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232C8FD5C3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598891C22EFE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EAC152;
	Wed,  5 Jun 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl4VLitU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7342F2B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612248; cv=none; b=g473yMDt3Mi/r9ZTXVn+d0zRoBKvG1OyfW3OwXZMcwE6xP9L9VIVT1mg43C+CONkvM2L00Cb1vmKJZdh8/Ucbecp6GjqSFNRq7LFE82llOPbTqyVqoE4gNP6eHmZ8iggCkfE5o6IOEvxfsOYgq+bBD22FHJdYGgS62nzlYQWHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612248; c=relaxed/simple;
	bh=dUTV71XmXtlYZZ1TirvFxoo1PTDfrRAJm9sogfuoBiI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=NYUCrmerOv7MsqeShyj1MaQW0CUNynOelBkDwFnf6fkeE4oGiAvel5r3GiNPo4XNOtw6t165ra/t08eB5UfRDFB4aug/mIU2pLT5E1cSb8g3nuOVFHu6pXKMwYdMDK1bX8LBTv25PDouiixaHfWWo/WDcRWsDGT6Ui2xGybYYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl4VLitU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F85EC2BD11;
	Wed,  5 Jun 2024 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612248;
	bh=dUTV71XmXtlYZZ1TirvFxoo1PTDfrRAJm9sogfuoBiI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Nl4VLitUSYhrOwKqITxiY7uKr9VBEwuGX7zeXzMARdOuewIuimA7WtMoFDnSz+d0U
	 gW/g5LHyQcb0qXqm+9L0FA05qTYh6OFwctKJaQjt6ctcDIYSIOnWIn10BpVHEMsriQ
	 XceX7uDIxPsSu80LrniK95FIFsJsIitFsImTEHIpSUOeuMJdJnNKbrvk1OoVZCKb5o
	 kJ3QWK3u24GrY03nUWxC9CE7qxvVGqlEoz6CmrDX0Qpm/u5TuAfpvrwMsX9nlbggur
	 LU6iyZQqoUUg3eRrEXaiPT7HkHKRK73hZTTedextnbhyeNEya5aPGNQfF31TcD8DkX
	 NyrJtaVF6vcXg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-next-20240605
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <87a5jzs6w2.fsf@kernel.org>
References: <87a5jzs6w2.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171761224540.2099453.10305785123277567469.kvalo@kernel.org>
Date: Wed,  5 Jun 2024 18:30:46 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
> 
> Please pull, more information in the tag below.
> 
> Kalle
> 
> The following changes since commit f1c26960b6afb9c38a4019ad36392c654db6e20e:
> 
>   Merge tag 'ath-next-20240502' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-05-03 13:30:19 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240605
> 
> for you to fetch changes up to 22767241e64427bbcffea2e2d51531ab467bc4ef:
> 
>   wifi: ath12k: add hw_link_id in ath12k_pdev (2024-06-03 16:15:50 +0300)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.11
> 
> ath12k
> 
> * remove unsupported tx monitor handling
> 
> * channel 2 in 6 GHz band support
> 
> * Spatial Multiplexing Power Save (SMPS) in 6 GHz band support
> 
> * multiple BSSID (MBSSID) and Enhanced Multi-BSSID Advertisements (EMA) support
> 
> * dynamic VLAN support
> 
> * add panic handler for resetting the firmware state
> 
> ath10k
> 
> * add qcom,no-msa-ready-indicator Device Tree property
> 
> * LED support for various chipsets
> 
> ----------------------------------------------------------------
> Aloka Dixit (9):
>       wifi: ath12k: advertise driver capabilities for MBSSID and EMA
>       wifi: ath12k: configure MBSSID params in vdev create/start
>       wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
>       wifi: ath12k: create a structure for WMI vdev up parameters
>       wifi: ath12k: configure MBSSID parameters in AP mode
>       wifi: ath12k: refactor arvif security parameter configuration
>       wifi: ath12k: add MBSSID beacon support
>       wifi: ath12k: add EMA beacon support
>       wifi: ath12k: skip sending vdev down for channel switch
> 
> Baochen Qiang (9):
>       wifi: ath12k: fix Smatch warnings on ath12k_core_suspend()
>       wifi: ath11k: refactor setting country code logic
>       wifi: ath11k: restore country code during resume
>       wifi: ath11k: fix wrong definition of CE ring's base address
>       wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
>       wifi: ath12k: fix wrong definition of CE ring's base address
>       wifi: ath12k: fix memory leak in ath12k_dp_rx_peer_frag_setup()
>       wifi: ath12k: do not process consecutive RDDM event
>       wifi: ath12k: add panic handler
> 
> Breno Leitao (2):
>       wifi: wil6210: Do not use embedded netdev in wil6210_priv
>       wifi: ath12k: allocate dummy net_device dynamically
> 
> Jeff Johnson (8):
>       wifi: ath11k: refactor CE remap & unmap
>       wifi: ath11k: unmap the CE in ath11k_ahb_probe() error path
>       wifi: ath12k: initialize 'ret' in ath12k_qmi_load_file_target_mem()
>       wifi: ath11k: initialize 'ret' in ath11k_qmi_load_file_target_mem()
>       wifi: ath11k: fix misspelling of "dma" in num_rxmda_per_pdev
>       wifi: ath12k: fix misspelling of "dma" in num_rxmda_per_pdev
>       wifi: ath12k: initialize 'ret' in ath12k_dp_rxdma_ring_sel_config_wcn7850()
>       wifi: ath12k: Fix devmem address prefix when logging
> 
> Kalle Valo (1):
>       wifi: ath11k: ath11k_mac_op_ipv6_changed(): use list_for_each_entry()
> 
> Kang Yang (5):
>       wifi: ath12k: remove unused variable monitor_flags
>       wifi: ath12k: avoid duplicated vdev stop
>       wifi: ath12k: avoid duplicated vdev down
>       wifi: ath12k: remove invalid peer create logic
>       wifi: ath12k: remove redundant peer delete for WCN7850
> 
> Karthikeyan Kathirvel (1):
>       wifi: ath12k: drop failed transmitted frames from metric calculation.
> 
> Karthikeyan Periyasamy (13):
>       wifi: ath12k: Refactor the hardware recovery procedure
>       wifi: ath12k: Refactor the hardware state
>       wifi: ath12k: Add lock to protect the hardware state
>       wifi: ath12k: Replace "chip" with "device" in hal Rx return buffer manager
>       wifi: ath12k: Refactor idle ring descriptor setup
>       wifi: ath12k: Introduce device index
>       wifi: ath12k: add multi device support for WBM idle ring buffer setup
>       wifi: ath12k: avoid double SW2HW_MACID conversion
>       wifi: ath12k: remove duplicate definition of MAX_RADIOS
>       wifi: ath12k: use correct MAX_RADIOS
>       wifi: ath12k: refactor rx descriptor CMEM configuration
>       wifi: ath12k: improve the rx descriptor error information
>       wifi: ath12k: add hw_link_id in ath12k_pdev
> 
> Lingbo Kong (1):
>       wifi: ath12k: fix ack signal strength calculation
> 
> Marc Gonzalez (2):
>       dt-bindings: net: wireless: ath10k: add qcom,no-msa-ready-indicator prop
>       wifi: ath10k: do not always wait for MSA_READY indicator
> 
> Muna Sinada (1):
>       wifi: ath12k: dynamic VLAN support
> 
> Nithyanantham Paramasivam (1):
>       wifi: ath12k: Fix tx completion ring (WBM2SW) setup failure
> 
> P Praneesh (3):
>       wifi: ath12k: change DMA direction while mapping reinjected packets
>       wifi: ath12k: fix invalid memory access while processing fragmented packets
>       wifi: ath12k: fix firmware crash during reo reinject
> 
> Pradeep Kumar Chitrapu (6):
>       wifi: ath12k: add channel 2 into 6 GHz channel list
>       wifi: ath12k: Correct 6 GHz frequency value in rx status
>       wifi: ath12k: fix survey dump collection in 6 GHz
>       wifi: ath12k: add 6 GHz params in peer assoc command
>       wifi: ath12k: refactor SMPS configuration
>       wifi: ath12k: support SMPS configuration for 6 GHz
> 
> Rob Herring (Arm) (1):
>       dt-bindings: net: wireless: ath11k: Drop "qcom,ipq8074-wcss-pil" from example
> 
> Sebastian Gottschall (1):
>       wifi: ath10k: add LED and GPIO controlling support for various chipsets
> 
> Sven Eckelmann (1):
>       wifi: ath12k: Don't drop tx_status in failure case
> 
> Tamizh Chelvam Raja (3):
>       wifi: ath12k: fix calling correct function for rx monitor mode
>       wifi: ath12k: Remove unsupported tx monitor handling
>       wifi: ath12k: Remove unused tcl_*_ring configuration
> 
> Venkateswara Naralasetty (1):
>       wifi: ath11k: skip status ring entry processing
> 
>  .../bindings/net/wireless/qcom,ath10k.yaml         |   5 +
>  .../bindings/net/wireless/qcom,ath11k.yaml         |   9 -
>  drivers/net/wireless/ath/ath10k/Kconfig            |   6 +
>  drivers/net/wireless/ath/ath10k/Makefile           |   1 +
>  drivers/net/wireless/ath/ath10k/core.c             |  32 ++
>  drivers/net/wireless/ath/ath10k/core.h             |   8 +
>  drivers/net/wireless/ath/ath10k/hw.h               |   1 +
>  drivers/net/wireless/ath/ath10k/leds.c             |  90 ++++
>  drivers/net/wireless/ath/ath10k/leds.h             |  34 ++
>  drivers/net/wireless/ath/ath10k/mac.c              |   1 +
>  drivers/net/wireless/ath/ath10k/qmi.c              |  11 +
>  drivers/net/wireless/ath/ath10k/qmi.h              |   1 +
>  drivers/net/wireless/ath/ath10k/wmi-ops.h          |  32 ++
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   2 +
>  drivers/net/wireless/ath/ath10k/wmi.c              |  54 ++
>  drivers/net/wireless/ath/ath10k/wmi.h              |  35 ++
>  drivers/net/wireless/ath/ath11k/ahb.c              |  57 +-
>  drivers/net/wireless/ath/ath11k/ce.h               |   6 +-
>  drivers/net/wireless/ath/ath11k/core.c             |  49 +-
>  drivers/net/wireless/ath/ath11k/debugfs.c          |   6 +-
>  drivers/net/wireless/ath/ath11k/dp.c               |  12 +-
>  drivers/net/wireless/ath/ath11k/dp_rx.c            | 104 +++-
>  drivers/net/wireless/ath/ath11k/dp_tx.c            |   6 +-
>  drivers/net/wireless/ath/ath11k/hal.c              |  16 +-
>  drivers/net/wireless/ath/ath11k/hal.h              |   2 +
>  drivers/net/wireless/ath/ath11k/hw.h               |   4 +-
>  drivers/net/wireless/ath/ath11k/mac.c              |  19 +-
>  drivers/net/wireless/ath/ath11k/qmi.c              |   2 +-
>  drivers/net/wireless/ath/ath11k/reg.c              |  18 +-
>  drivers/net/wireless/ath/ath11k/reg.h              |   4 +-
>  drivers/net/wireless/ath/ath11k/wmi.c              |   2 +-
>  drivers/net/wireless/ath/ath12k/ce.h               |   6 +-
>  drivers/net/wireless/ath/ath12k/core.c             | 144 ++++--
>  drivers/net/wireless/ath/ath12k/core.h             |  44 +-
>  drivers/net/wireless/ath/ath12k/dp.c               |  83 +--
>  drivers/net/wireless/ath/ath12k/dp.h               |   4 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c           |  40 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c            | 115 ++---
>  drivers/net/wireless/ath/ath12k/dp_tx.c            | 165 +++---
>  drivers/net/wireless/ath/ath12k/dp_tx.h            |   5 +-
>  drivers/net/wireless/ath/ath12k/hal.c              |   5 +-
>  drivers/net/wireless/ath/ath12k/hal.h              |  21 +-
>  drivers/net/wireless/ath/ath12k/hal_desc.h         |  47 +-
>  drivers/net/wireless/ath/ath12k/hal_tx.h           |   4 +-
>  drivers/net/wireless/ath/ath12k/hif.h              |   9 +
>  drivers/net/wireless/ath/ath12k/hw.c               |  23 +-
>  drivers/net/wireless/ath/ath12k/hw.h               |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c              | 574 ++++++++++++++++-----
>  drivers/net/wireless/ath/ath12k/mhi.c              |  11 +
>  drivers/net/wireless/ath/ath12k/pci.c              |  39 +-
>  drivers/net/wireless/ath/ath12k/pci.h              |   1 +
>  drivers/net/wireless/ath/ath12k/qmi.c              |   8 +-
>  drivers/net/wireless/ath/ath12k/reg.c              |  19 +-
>  drivers/net/wireless/ath/ath12k/wmi.c              |  55 +-
>  drivers/net/wireless/ath/ath12k/wmi.h              |  48 +-
>  drivers/net/wireless/ath/wil6210/netdev.c          |  21 +-
>  drivers/net/wireless/ath/wil6210/wil6210.h         |   2 +-
>  57 files changed, 1516 insertions(+), 610 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath10k/leds.c
>  create mode 100644 drivers/net/wireless/ath/ath10k/leds.h

Pulled, thanks.

a46300b1b09b Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/87a5jzs6w2.fsf@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


