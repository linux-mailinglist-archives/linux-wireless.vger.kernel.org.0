Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E375711E12D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfLMJxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 04:53:19 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:45372 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJxT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 04:53:19 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ifhdO-009dx9-Gb; Fri, 13 Dec 2019 10:53:18 +0100
Message-ID: <93ad9a422ea97bd4cca1c07f6088ba9025adbb34.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] mac80211_hwsim: enable parent TSF feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Dec 2019 10:53:17 +0100
In-Reply-To: <20191122171401.8788-1-prestwoj@gmail.com> (sfid-20191122_181704_319217_3F437F0C)
References: <20191122171401.8788-1-prestwoj@gmail.com>
         (sfid-20191122_181704_319217_3F437F0C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 09:14 -0800, James Prestwood wrote:
> Support for this is already in nl80211, and some code paths in
> mac80211_hwsim already set the rx_status to allow the parent TSF
> value to be sent to user space.

This really should come *after* the second patch, not before.

I'd have reordered it, but now that you need to fix the second patch
anyway it'll be easier if you also reorder and reword this.

johannes

