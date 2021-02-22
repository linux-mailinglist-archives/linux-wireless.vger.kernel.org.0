Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7253B3217FB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBVNHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 08:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBVNFL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 08:05:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C008B64E41;
        Mon, 22 Feb 2021 13:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613999070;
        bh=MB7t7QTHS8bJGOrTiUCaig87LbW92zJlrCFpXb0aiTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEa4hrdtrqkoo7TPeVUWxnTFTwUkIQtZsH5pRc+j93k/aYN9QUmEC8VQEAjr24yde
         NJw/qCCoA976qb8TFIGAXDk2kaT2ZdSgLOuOAu+iyWph0zp4Y/RabsxpSrEk/pMLSO
         GpklUw2G+YIWx3aaG52pq16Ryr3fgYN3LV+uzxL+OVLRRrQNqabLnex1YtSKGPm1Ee
         BxZ6EfL6RBq5F3p6bp/Tpg6jdft8IhxQ60OQER5QbAFLRLCEqGHuJgQ5b7R7Pskw62
         cFUcIFJaKmkju2eSJ9ZsJ5LG956FkxL25S0Efli2TlXNEQcl2i3JFLMKYADQ1VwKBE
         1qFla75qa+Gbg==
Received: by pali.im (Postfix)
        id 47F6FC9A; Mon, 22 Feb 2021 14:04:28 +0100 (CET)
Date:   Mon, 22 Feb 2021 14:04:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-firmware@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: New firmware 16.68.10.p56 for mwifiex 88W8997 SDIO wifi chip
Message-ID: <20210222130428.gpafcbmt6fktr7o5@pali>
References: <20201113154727.ndk5pcijd2qdvrrf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113154727.ndk5pcijd2qdvrrf@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Sharvari!

I got an update that you are new mwifiex maintainer. Could you please
look at the way how to update mwifiex firmware for 88W8997 SDIO wifi
chip into the linux-firmware repository?

On Friday 13 November 2020 16:47:27 Pali Rohár wrote:
> Hello Ganapathi,
> 
> there is a new firmware version 16.68.10.p56 for 88W8997 SDIO wifi chip.
> Current version of firmware file sdsd8997_combo_v4.bin for this chip in
> linux-firmware repository is 16.68.1.p197:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/log/mrvl/sdsd8997_combo_v4.bin
> 
> Ganapathi, could you please send an update for this firmware file?
