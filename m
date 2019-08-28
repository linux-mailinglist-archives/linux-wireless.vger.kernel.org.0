Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44808A0AA4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfH1Toc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 15:44:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41002 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfH1Tob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 15:44:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i33rk-00079a-Hx; Wed, 28 Aug 2019 21:44:25 +0200
Message-ID: <18c4232675c7b4f13fbfe9e5d8e9364a0908f316.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: add local BSS receive time to survey
 information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>, Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 28 Aug 2019 21:44:22 +0200
In-Reply-To: <9189B2C1-6E5B-4457-9354-A010F946EE33@holtmann.org>
References: <20190828102042.58016-1-nbd@nbd.name>
         <9189B2C1-6E5B-4457-9354-A010F946EE33@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marcel,

> ... [snip]

Please trim quotes a bit.

> > 	NL80211_SURVEY_INFO_PAD,
> > +	NL80211_SURVEY_INFO_TIME_BSS_RX,
> 
> wouldn’t this go before the PAD attribute?

No, as usual, that would break ABI. PAD is a regular attribute, just
empty and ignored for aligning 64-bit values.

johannes

