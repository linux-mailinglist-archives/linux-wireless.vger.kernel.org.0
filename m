Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3352669BA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgIKUqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 16:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgIKUqE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 16:46:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED7CC061573
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 13:46:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kGpvl-002OS7-M5; Fri, 11 Sep 2020 22:46:01 +0200
Message-ID: <ad7876d3cb0e5ce7cef75171384180f344c392ea.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: Add radiotap channel flag option for 6GHz band
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 22:46:00 +0200
In-Reply-To: <010101747eea5fbb-4c045b3e-1db2-44aa-b093-8f621da60b43-000000@us-west-2.amazonses.com>
References: <010101747ee4b985-86863ec8-33e2-4f78-9d9b-93110bfa29fc-000000@us-west-2.amazonses.com>
         <5225561f9f5c104bc84ab6e7f183de0ab5e0ea6d.camel@sipsolutions.net>
         <010101747eea5fbb-4c045b3e-1db2-44aa-b093-8f621da60b43-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-09-11 at 20:45 +0000, Aloka Dixit wrote:
> 
> What do you mean by we cannot add to radiotap in a kernel patch?

Radiotap is a Linux-independent "standard". Would have to go through the
process there to change it.

johannes

