Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC46D7C17
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjDEL71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjDEL70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 07:59:26 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1591FC9
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 04:59:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 1216820109;
        Wed,  5 Apr 2023 13:59:22 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lNj6Y5oyOqm2; Wed,  5 Apr 2023 13:59:21 +0200 (CEST)
Received: from eyak.inrialpe.fr (82-64-217-88.subs.proxad.net [82.64.217.88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id E497F200EC;
        Wed,  5 Apr 2023 13:59:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by eyak.inrialpe.fr (Postfix) with ESMTP id 6185C1A12C6;
        Wed,  5 Apr 2023 13:59:21 +0200 (CEST)
Message-ID: <d055fe8e-0bf7-7e6d-4404-382697753a66@debian.org>
Date:   Wed, 5 Apr 2023 13:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.22)
 Gecko/20091109 Lightning/0.8 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
Content-Language: fr, en-US
To:     James <bjlockie@lockie.ca>, linux-wireless@vger.kernel.org
References: <ad820d2e-c984-8603-9821-e6c1d426c4f8@debian.org>
 <f3039ab6-25f4-d003-059a-c0a75aa24127@lockie.ca>
From:   Vincent Danjean <vdanjean@debian.org>
Subject: Re: Bug report about ath9k
In-Reply-To: <f3039ab6-25f4-d003-059a-c0a75aa24127@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

   Hi,

Le 22/02/2023 à 01:32, James a écrit :
> Try disabling power saving.
> w dev wlanX set power_save off
> Maybe that command.

   For the record, this did not change anything. The problem seemed
triggered by an external event : no log during the week I was not at
home (but the server was still online and used for regular backup,
asterisk, etc. with a few domotic object still connected via wifi)
However, when present, I saw an error just after midnight nearly
all days (with some few exceptions) and sometimes at other
times (5 PM, 8 AM, etc.)
   I did not succeeded at finding the external cause. But I "fixed"
the problem by adding the "iommu=pt" kernel parameter.
As I'm using the network card on the host, if I'm correct, this
parameter just tells linux to *not* use iommu for this device in
this case.

   So, I think that the ath9k has a bug wrt iommu. If you ever want
I tried some things (debug, new versions, etc.), I can do it.
Just tell me.
   I did not tried to manager the device in a VM (that would
require the use of iommu for this device)

   Regards
     Vincent

