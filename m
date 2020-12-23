Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7CF2E1C61
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Dec 2020 13:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgLWMue (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Dec 2020 07:50:34 -0500
Received: from mail.w1.fi ([212.71.239.96]:39326 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgLWMue (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Dec 2020 07:50:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id B6F4611C85;
        Wed, 23 Dec 2020 12:49:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LgxBzmvx5dJ6; Wed, 23 Dec 2020 12:49:51 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 23 Dec 2020 14:46:22 +0200
Date:   Wed, 23 Dec 2020 14:46:22 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>, vnaralas@codeaurora.org,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCHv2 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
Message-ID: <20201223124622.GA12620@w1.fi>
References: <1598257589-19091-1-git-send-email-vnaralas@codeaurora.org>
 <4b4a0d79a243c1c3b8044730da0493c96ba294bf.camel@sipsolutions.net>
 <871rilf2th.fsf@codeaurora.org>
 <dbaa655c3f15f800f73b7c19f2b1a054@codeaurora.org>
 <87eelr1oq9.fsf@codeaurora.org>
 <f6c148a3-73de-1481-5f63-2deecb599468@broadcom.com>
 <81ced18ac5b87a17cf31797cf91669bc@codeaurora.org>
 <87sg9rtugu.fsf@codeaurora.org>
 <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c779b7c17b8ea40c2bba08d8fca98e83581580.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 06, 2020 at 11:41:06AM +0100, Johannes Berg wrote:
> I suspect that SET_POWERSAVE might be confusing.

Why? Isn't the use case here very similar to the existing station mode
use of power save even if the power saving mechanism is more of a vendor
specific extension that applies while there are no associated stations?

> Perhaps just with an attribute used in START_AP (and CHANGE_BEACON if
> needed) would be sufficient?

NL80211_CMD_START_AP with a new attribute (or even re-use of
NL80211_ATTR_PS_STATE) might work for a case where this does not need to
be changed dynamically during the lifetime of the BSS.
NL80211_CMD_SET_BEACON (which maps to the change_beacon() callback)
feels like something that is currently limited to Beacon data updates
with its use of struct cfg80211_beacon_data instead of struct
cfg80211_ap_settings..

That SET_BEACON name is still from the old NEW/SET/DEL_BEACON time.
Should that be renamed to NL80211_CMD_UPDATE_AP if we extend this to
changes that are not really targeting the Beacon frame payload itself?
And should the cfg80211_beacon_data argument be replaced with
cfg80211_ap_settings? It looks like we already have some struct
cfg80211_ap_settings values like inactivity_timeout and beacon_rate (and
maybe some HE parameters?) that one might want to update during the
lifetime of the BSS..

-- 
Jouni Malinen                                            PGP id EFC895FA
