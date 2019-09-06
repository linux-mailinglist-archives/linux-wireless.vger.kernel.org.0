Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6424AC2CC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2019 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfIFXIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 19:08:50 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:52601 "EHLO
        14.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbfIFXIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 19:08:50 -0400
X-Greylist: delayed 6601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 19:08:49 EDT
Received: from player770.ha.ovh.net (unknown [10.108.35.124])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id B41CB24CD2D
        for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2019 22:41:42 +0200 (CEST)
Received: from awhome.eu (p579AAC71.dip0.t-ipconnect.de [87.154.172.113])
        (Authenticated sender: postmaster@awhome.eu)
        by player770.ha.ovh.net (Postfix) with ESMTPSA id 4C05198C6C24;
        Fri,  6 Sep 2019 20:41:39 +0000 (UTC)
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1567802498;
        bh=d0aScw7BCx55bqh8LfPetRnRw5IBfRzycfqZrrrRPeI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ObER0WPUTJLvpcfS6uHxtAJ42iv/rta4oQLYYtXkP3kzNmqZAS2+e5A67+stebOwy
         h5KyTHCBCaQhbfpjegcBo9XnswcMvz9LkK3+ayUcjGJdPCGsAvdVs8wL2GI+Hb7UQH
         QT/AOmIUdH4b0Rhh3PXr1Q57nSTRVfQWgqB0bFYo=
To:     johannes@sipsolutions.net, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
References: <20190819180540.2855-1-alexander@wetzel-home.de>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <7f05a2e7-c3ae-1101-39be-b55cf10452b3@wetzel-home.de>
Date:   Fri, 6 Sep 2019 22:41:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190819180540.2855-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14161006082064260296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejledgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 19.08.19 um 20:05 schrieb Alexander Wetzel:
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
> ---
> 
> This is basically the V3 of the patch, but the other patches were part
> of series and this here is the first standalone version.
> 
> V1: https://patchwork.kernel.org/patch/10931879/
> V2: https://patchwork.kernel.org/patch/11024137/
> 
> V1 become deprecated due to redesigning the Extended Key ID support API.
> V2 became deprecated due to the discovery that the 22000 is not (yet)
> able to support Extended Key ID.
> 
> The patch is still super trivial, but I cross checked that Extended Key
> ID support is enabled with my old 3168 card and disabled with my new
> AX200 card.

For what it's worth:

I just upgraded my test AP from the initial AC 3168 to an AC 9560 card 
after the AC 201 turned out to be incompatible (for now).

So I can now confirm that Extended Key ID is also working with this card 
and the patch here. (Tested against my "reference" system using an old 
Intel Ultimate-N 6300.)

Alexander
