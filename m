Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2F1814EF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgCKJbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:31:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45590 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgCKJbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:31:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBxiR-000vTt-GU; Wed, 11 Mar 2020 10:31:51 +0100
Message-ID: <f230965a23ee69341a402dff15efb67c7c221bde.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] Revert "mac80211: support
 NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Denis Kenzior <denkenz@gmail.com>, Jouni Malinen <j@w1.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 11 Mar 2020 10:31:50 +0100
In-Reply-To: <ed6047dd-e71d-0cff-3c1f-5a11a53c6d8c@tu-ilmenau.de>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
         <c9fba32a-6959-a93a-3119-23915053538c@gmail.com>
         <53190ece697ab7d9e83fdd667eaf9e05a4418193.camel@sipsolutions.net>
         <6e723a78-db68-8ffb-986a-4a3961107f72@gmail.com>
         <1a56c641eaa03c99dc9a90208902d8bb1ca1b0aa.camel@sipsolutions.net>
         <048b81db-8e92-7fe0-1f5c-3b6f9ea1a1f1@gmail.com>
         <366b1599374240ef194bf7eb6e1e47a8b675f474.camel@sipsolutions.net>
         <978dab89-343a-3fc9-dbdb-7acf87d735ca@gmail.com>
         <20200225110018.GA7561@w1.fi>
         <957c6850-b26b-4cfd-5bc9-d77400e621b3@gmail.com>
         <ed6047dd-e71d-0cff-3c1f-5a11a53c6d8c@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-03-04 at 17:24 +0100, Markus Theil wrote:

> Is there any consensus on how to move on in this discussion? In my
> opinion a pragmatic way would be to make rx forwarding of pre-auth
> frames optional with a flag which can be set whenever
> NL80211_ATTR_CONTROL_PORT_OVER_NL80211 is included, like Denis has
> already proposed. We could call this flag for example
> NL80211_ATTR_CONTROL_PORT_NO_PREAUTH.

Yeah, that seems right.

Do you want to make the patch?

johannes

