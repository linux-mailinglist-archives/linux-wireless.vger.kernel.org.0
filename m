Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177F47676A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGZN0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 09:26:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49074 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfGZN0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 09:26:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hr0Ez-0003mV-Kb; Fri, 26 Jul 2019 15:26:33 +0200
Message-ID: <f2e16d10ce3eb3ff08c97c27424b824b8e012553.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211_hwsim: Register support for HE meshpoint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Date:   Fri, 26 Jul 2019 15:26:32 +0200
In-Reply-To: <20190724163359.3507-3-sven@narfation.org> (sfid-20190724_183423_401572_761C0A47)
References: <20190724163359.3507-1-sven@narfation.org>
         <20190724163359.3507-3-sven@narfation.org>
         (sfid-20190724_183423_401572_761C0A47)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-24 at 18:33 +0200, Sven Eckelmann wrote:
> From: Sven Eckelmann <seckelmann@datto.com>
> 
> Some features of 802.11ax without central organizing (AP) STA can also be
> used in mesh mode. hwsim can be used to assist initial development of these
> features without having access to HW.
> 
> Signed-off-by: Sven Eckelmann <seckelmann@datto.com>

Even with the tshark workaround in place, this breaks 68 mesh-related
tests in hwsim tests. Jouni says only 3 use tshark ...

johannes

