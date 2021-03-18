Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE5340AFD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCRRGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhCRRGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 13:06:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC7C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 10:06:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMw60-000EWb-FW; Thu, 18 Mar 2021 18:06:04 +0100
Message-ID: <fee413b8499827dcdbd90cdb968aaa9210de750f.camel@sipsolutions.net>
Subject: Re: WMM doesn't work for VLAN frame
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 18 Mar 2021 18:06:03 +0100
In-Reply-To: <PR3PR01MB67144B33C65712847FFB558D906B9@PR3PR01MB6714.eurprd01.prod.exchangelabs.com> (sfid-20210316_161819_662475_641D2A95)
References: <PR3PR01MB67144B33C65712847FFB558D906B9@PR3PR01MB6714.eurprd01.prod.exchangelabs.com>
         (sfid-20210316_161819_662475_641D2A95)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-03-16 at 15:15 +0000, Cedric VONCKEN wrote:
> 
> 	Explantation of the issue
> 		1. The validate_xmit_vlan function add the the vlan tag in the skb frame, set skb->protocol to VLAN protocol (0x8100) and set skb->vlan_tci to 0.
> 		2. The cfg80211_classify8021d use these fields to determine the frame priority, but the skb->protocol value (0x8100) is not handled byt this function and this function return a default value 0.

(some line breaks would've been nice)

Well, since your own commit (!) c6ca5e28bc005 the VLAN TCI is used. If
the VLAN TCI is 0, then you don't get anything else?

Not sure what you were expecting different now?


Oh. You're saying that somehow the order of functions changed? But
validate_xmit_vlan() only pushes a hw offload vlan tag into the frame
(wifi devices aren't offload capable)?

johannes

