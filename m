Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22191666FA5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjALK25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 05:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjALK15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 05:27:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B26CE3D
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 02:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=idpY+tcZJlIH1Oza9P0UKgOdZmtNxI2+dBakrQdRMvk=;
        t=1673519099; x=1674728699; b=gn3rtoj+2hG1HLWX4QS62kNnWUyQ6WNGjUjLlrYfsG1ocWz
        E2OoVuGcMYVdrAq3dDW1jr36AXRZZgiaFevQztX0l4HoEP/2Z9Zj6YasELJ4nFn0Edl1bWa2Z4JMP
        dcmNfB0C86BRfJ6hEKqYJAJ+tsbNVCGmge2WdCRYUKjLu+nizGnOYsLn4kbBAh5CuV2dHQZWPH6/d
        HHVqJ22KuPp28KPlgg+RkPs9Y9JnpywpXaW5HFHF57xmiE2uF7yhe35DzhqcATTarlxiFyiULcB5E
        YTBrt11v4QuyXchUtylb7O2IprPVbSRfin8PeWPJaAb3AZLkl2ykomTFwypvOkOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pFulV-00H36X-0o;
        Thu, 12 Jan 2023 11:24:57 +0100
Message-ID: <d8ceeaa245a01b98d31933c934c16d2a9dc8df36.camel@sipsolutions.net>
Subject: Re: [RFC v2 1/6] mac80211: modify tx-power level annotation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Date:   Thu, 12 Jan 2023 11:24:56 +0100
In-Reply-To: <20220920104032.496697-2-jelonek.jonas@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-2-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
> =20
> +/**
> + * struct ieee80211_hw_txpower_range - Power range for transmit power
> + *
> + * This struct can be used by drivers to define multiple tx-power ranges=
 with
> + * different scales according to the hardware capabilities. A tx-power r=
ange
> + * describe either absolute power levels or power offsets relative to a =
base
> + * power.
> + *
> + * @start_idx The starting idx of the range. @start_idx is always the lo=
west
> + * 	idx of the power range.
> + * @start_pwr The power level at idx @start_idx in 0.25 dBm units.
> + * @n_levels How many power levels this range has.
> + * @pwr_step The power step width in 0.25 dBm units.

Need colons for valid kernel-doc, I believe.

johannes

