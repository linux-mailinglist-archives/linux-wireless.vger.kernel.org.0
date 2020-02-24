Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168F416A61B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 13:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXM1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 07:27:48 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:32944 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXM1r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 07:27:47 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j6Cpu-006YqF-Be; Mon, 24 Feb 2020 13:27:46 +0100
Message-ID: <4b0d571a735f9b868ddef6054c714deb5fcad50f.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: only send control port frames over nl80211
 control port
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 24 Feb 2020 13:27:45 +0100
In-Reply-To: <20200224121954.66739-1-markus.theil@tu-ilmenau.de>
References: <20200224121954.66739-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-02-24 at 13:19 +0100, Markus Theil wrote:
> As Jouni recently pointed out, the nl80211 control should only transmit
> and receive EAPOL frames. This patch removes forwarding of
> preauthentication frames over the control port. They are handled as
> ordinary data frames again.

Yeah, we need to do something like this, but this will break iwd as it
relies on this RX path when the feature flag is set.

johannes

