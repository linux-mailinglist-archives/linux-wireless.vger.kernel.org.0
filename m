Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8667794DAC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfHSTPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 15:15:36 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46526 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfHSTPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 15:15:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzmkD-000263-Vk; Mon, 19 Aug 2019 20:51:06 +0200
Message-ID: <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Mon, 19 Aug 2019 20:51:03 +0200
In-Reply-To: <20190819180540.2855-1-alexander@wetzel-home.de>
References: <20190819180540.2855-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 20:05 +0200, Alexander Wetzel wrote:
> All iwlwifi cards below the 22000 series are able to handle multiple
> keyids per STA and allow the selection of the encryption key per MPDU.
> 
> These are therefore fully compatible with the Extended Key ID support
> implementation in mac80211.
> 
> Enable Extended Key ID support for all dvm cards and the mvm cards not
> using the incompatible new Tx API introduced for the 22000 series.
> 
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

LGTM.

> +
> +	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
> +	 * the hw, preventing us to control which key(id) to use per MPDU.
> +	 * Till that's fixed we can't use Extended Key ID for the newer cards.

Technically we still don't need per MPDU, we just need to switch which
one to use for TX after installing it for RX already.

johannes

