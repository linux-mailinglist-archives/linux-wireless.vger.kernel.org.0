Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6923A2B0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgHCKU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgHCKU5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 06:20:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07615C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 03:20:57 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2XaR-00Fcps-9p; Mon, 03 Aug 2020 12:20:55 +0200
Message-ID: <df36ecfb6fd72531727a0322f060a57761985294.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 03 Aug 2020 12:20:54 +0200
In-Reply-To: <20200715230514.26792-2-alokad@codeaurora.org>
References: <20200715230514.26792-1-alokad@codeaurora.org>
         <20200715230514.26792-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-07-15 at 16:05 -0700, Aloka Dixit wrote:
> This patch adds new attributes to support unsolicited broadcast
> probe response transmission used for in-band
> discovery in 6GHz band (IEEE P802.11ax/D6.0 26.17.2.3.2, AP behavior for
> fast passive scanning).
> The new attribute, NL80211_ATTR_UNSOL_BCAST_PROBE_RESP, is nested which
> supports following parameters:
> (1) NL80211_UNSOL_BCAST_PROBE_RESP_INT - Packet interval
> (2) NL80211_UNSOL_BCAST_PROBE_RESP_TMPL - Template data

And maybe some driver support flag is needed?

johannes

