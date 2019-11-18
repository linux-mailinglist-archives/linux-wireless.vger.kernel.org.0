Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2911110056A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRMPi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 07:15:38 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33360 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKRMPi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 07:15:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iWfwM-00034g-SE; Mon, 18 Nov 2019 13:15:35 +0100
Message-ID: <e49a74513f287a1343067f51335570094ae2edae.camel@sipsolutions.net>
Subject: Re: [PATCH v4] mac80211: Drop the packets whose source or
 destination mac address is empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Ming Chen <ming032217@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Date:   Mon, 18 Nov 2019 13:15:33 +0100
In-Reply-To: <87blt9ctd4.fsf@toke.dk>
References: <20191116060833.45752-1-ming.chen@watchguard.com>
         <87blt9ctd4.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-11-18 at 12:32 +0100, Toke Høiland-Jørgensen wrote:

> > Dropping this kind of error packet before it goes into the driver,
> > should be the right direction.
> 
> So I still wonder why this happens from higher up in the stack. If
> there's a legitimate reason, maybe dropping the packet is not the right
> thing? And if there is *no* legitimate reason, maybe the packet should
> be dropped higher up in the stack instead?

Agree, this is really weird, it'd be good to know the actual packet this
happens with. Don't think I've ever seen this.

johannes

