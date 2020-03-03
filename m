Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B91779BE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgCCO7g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 09:59:36 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56746 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgCCO7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 09:59:36 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j991C-00CzRQ-0s; Tue, 03 Mar 2020 15:59:34 +0100
Message-ID: <5d6760e94097b3c11c7244076befeb77066d02c8.camel@sipsolutions.net>
Subject: Re: Any reason AID is not in the NL80211_STA_INFO enumeration?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 03 Mar 2020 15:59:32 +0100
In-Reply-To: <07235202-4134-f01a-5083-4c56c1ed604a@candelatech.com>
References: <5E4B39B2.8050905@candelatech.com>
         <3fcaaf0ba9ed726c863f9f1e7c5d61c08ca40795.camel@sipsolutions.net>
         <29006a9e-4de2-1733-1a8a-a5aae686fd42@candelatech.com>
         <da15dc015f2992a702cc585c510e009a83b8fdb1.camel@sipsolutions.net>
         <07235202-4134-f01a-5083-4c56c1ed604a@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-03 at 06:57 -0800, Ben Greear wrote:
> 
> Although it is a bit weird, I was thinking to always return the AID as part of the station
> dump, and for station netdevs, use the local netdev AID, and for APs, use the remote station AID.
> 
> That seems a bit cleaner to me than having two separate ways to get the AID for stations and APs,
> but I can do two separate ways if you prefer that.

I don't really agree that it's cleaner - by definition, the data in a
station is data about that station, not data about "self".

We may not have a great way right now to show the latter ('data about
self')? But I still don't think we should mix it.

johannes

