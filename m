Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8272115D424
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgBNIyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 03:54:08 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38790 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNIyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 03:54:08 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2WjX-00BBhB-E8; Fri, 14 Feb 2020 09:53:59 +0100
Message-ID: <57a23c8b569ff0c9268252f93902c81c0b90a21c.camel@sipsolutions.net>
Subject: Re: [PATCH] [PATCH] mac80211: fix wrong 160/80+80 Mhz setting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com
Date:   Fri, 14 Feb 2020 09:53:58 +0100
In-Reply-To: <20200210130728.23674-1-shay.bar@celeno.com> (sfid-20200210_140754_468849_45E94991)
References: <20200209152818.4630-1-shay.bar@celeno.com>
         <20200210130728.23674-1-shay.bar@celeno.com>
         (sfid-20200210_140754_468849_45E94991)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2020-02-10 at 15:07 +0200, Shay Bar wrote:
> Before this patch, STA's would set new width of 160/80+80 Mhz based on AP capability only.
> This is wrong because STA may not support > 80Mhz BW.
> Fix is to verify STA has 160/80+80 Mhz capability before increasing its width to > 80Mhz.

Oh, good catch.

> +	vht_cap = hw->wiphy->bands[chandef->chan->band]->vht_cap.cap;

But I think this is possibly wrong, we might have VHT capa overrides?

Anyway, I've applied this as a fix now - we can fix it more later.

johannes

