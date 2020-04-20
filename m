Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692191B177E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTUsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 16:48:55 -0400
Received: from mail.w1.fi ([212.71.239.96]:33156 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgDTUsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 16:48:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 0D6B5117AB;
        Mon, 20 Apr 2020 20:48:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ljvdoPOFeMA6; Mon, 20 Apr 2020 20:48:51 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Mon, 20 Apr 2020 23:47:46 +0300
Date:   Mon, 20 Apr 2020 23:47:46 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH] cfg80211: support multicast RX registration
Message-ID: <20200420204746.GA15385@w1.fi>
References: <20200417124013.c46238801048.Ib041d437ce0bff28a0c6d5dc915f68f1d8591002@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417124013.c46238801048.Ib041d437ce0bff28a0c6d5dc915f68f1d8591002@changeid>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 17, 2020 at 12:40:15PM +0200, Johannes Berg wrote:
> For DPP, there's a need to receive multicast action frames,
> but many drivers need a special filter configuration for this.
> 
> Support announcing from userspace in the management registration
> that multicast RX is required, with an extended feature flag if
> the driver handles this.

Thanks, this looks good to me. I did some testing with mac80211 and
wpa_supplicant changes to confirm that the DPP listen case can be passed
through this to the driver as needed.

-- 
Jouni Malinen                                            PGP id EFC895FA
