Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF72542B0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgH0JsL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0JsI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 05:48:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFBC061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 02:48:08 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBEVq-00BX86-Vh; Thu, 27 Aug 2020 11:48:07 +0200
Message-ID: <5ca724421a6a9d8be3402e10dbd62a19b910b03a.camel@sipsolutions.net>
Subject: Re: [PATCH v5 2/2] mac80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 27 Aug 2020 11:48:06 +0200
In-Reply-To: <20200805011838.28166-3-alokad@codeaurora.org>
References: <20200805011838.28166-1-alokad@codeaurora.org>
         <20200805011838.28166-3-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> + *  @IEEE80211_HW_SUPPORTS_FILS_DISCOVERY: Hardware/driver supports FILS
> + *	discovery frame transmission


nit: extra space before the @

but in any case you really ought to just remove this, the driver can set
up whatever method you decide to use in cfg80211 (e.g. extended feature
flag) - no need for mac80211 to have extra code just to pass it through.

The flags here are intended for things that only mac80211 cares about.

johannes


