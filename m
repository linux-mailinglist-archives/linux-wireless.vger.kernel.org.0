Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB84D0133
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiCGO3N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 09:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCGO3M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 09:29:12 -0500
X-Greylist: delayed 91683 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 06:28:18 PST
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1B24BCB
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 06:28:18 -0800 (PST)
Received: (Authenticated sender: pbl@bestov.io)
        by mail.gandi.net (Postfix) with ESMTPSA id 51FF7E0007;
        Mon,  7 Mar 2022 14:28:15 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Mar 2022 15:28:15 +0100
Message-Id: <CIDPF6OMQ0MJ.10W2JI66K5FM1@enhorning>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: MK7921K de-auths from AP every 5 minutes
From:   "Riccardo Paolo Bestetti" <pbl@bestov.io>
To:     "James" <bjlockie@lockie.ca>
References: <CICSX6EXTZ6U.MYGFTUDU5ZKW@enhorning>
 <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca>
In-Reply-To: <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon Mar 7, 2022 at 3:15 PM CET, James wrote:
> You could try a different channel?
I tried letting the AP pick channels, and I also tried manually picking
some of the most spectrally-uneventful (as measured by both the AP and
my smartphone) channels in my area. No difference.

> Is it 2.4 or 5GHz?
5 GHz. I have no 2.4GHz network.

Riccardo

