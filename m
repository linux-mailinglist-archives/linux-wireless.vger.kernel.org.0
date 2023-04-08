Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19876DB7EA
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Apr 2023 03:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDHBHW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHBHW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 21:07:22 -0400
Received: from stone.woods.net (stone.woods.net [74.50.54.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6655FBB80
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 18:07:18 -0700 (PDT)
Received: from sneaky (66.29.179.130.static.utbb.net [66.29.179.130])
        by stone.woods.net (Postfix) with ESMTPSA id A77F580F7;
        Sat,  8 Apr 2023 01:07:16 +0000 (UTC)
Date:   Fri, 7 Apr 2023 19:07:15 -0600
From:   Aaron Dewell <acd@woods.net>
To:     James <bjlockie@lockie.ca>
Cc:     "=?utf-8?Q?linux-wireless=40vger.kernel.org?=" 
        <linux-wireless@vger.kernel.org>
Message-ID: <9AEF6A8A-44F0-4863-9467-44C137D7430A@getmailspring.com>
In-Reply-To: <76605abc-17a6-61cd-23e9-23a7274f00d1@lockie.ca>
References: <76605abc-17a6-61cd-23e9-23a7274f00d1@lockie.ca>
Subject: Re: ax204/Intel NUC13 i9
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Apr 7 2023, at 5:40 pm, James <bjlockie@lockie.ca> wrote:
> https://www.google.com/search?client=firefox-b-d&q=iwlwifi%3A+No+config+found
> 
> 
> I suspect a firmware problem.
> 
> Do you know how to install the latest firmware from git?
> 
> I would copy it to /lib/firmware if that is your distro keeps it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

Did that first thing.
