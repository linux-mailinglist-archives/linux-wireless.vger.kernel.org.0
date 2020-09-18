Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763CA26F9C3
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRJ7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRJ7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 05:59:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990FC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 02:59:37 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDB2-006Ayx-3B; Fri, 18 Sep 2020 11:59:36 +0200
Message-ID: <be2e3af7f5123915fa27c514068d9a8149f476af.camel@sipsolutions.net>
Subject: Re: [PATCH v4 03/14] mac80211: skip encap offload for tx
 multicast/control packets
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        John Crispin <john@phrozen.org>
Date:   Fri, 18 Sep 2020 11:59:35 +0200
In-Reply-To: <20200908123702.88454-4-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
         <20200908123702.88454-4-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 14:36 +0200, Felix Fietkau wrote:
> This simplifies the checks in the encap offload tx handler and allows using
> it in cases where software crypto is used for multicast packets, e.g. when
> using an AP_VLAN.

Similar situation here ...

johannes

