Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8467C918
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjAZKui (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbjAZKuf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 05:50:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD411457F2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=uxb6AnpT8zwy9btrX85Tu9tarEKKrblSBGHJo+4fsr0=; b=oFVa5
        7JjkA+jiM3EspH5G+PylPcauqIYBI3wIoNHiHzrEqKJVnpEt3g7xgexdC0t1kKZ3rwVCvrl4RIudI
        WPmM5fP2u3J+hHcQX9+FUiBP42f1blG/lDDHf0RWLlQn9OUU/WhV01TWBLD/zyfvM9iE3tzdp4S2d
        LtTp9upJFUiuCNc6QsEgvPRxRH+Shzp98lb0PCqL+6cNNcAtvn3pM9LnGPmMgDPYJfTUHtPcrhBDJ
        BaLUvvUMPpWPEH1vgnQW6oIagqTHvwSMxhViPUOT/ryAFtxnAxySfagYyerzK9QXuCeu0Oyi8wDE0
        WRdhulNb8dQV6aZfjXUQZNe5V4kiA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pKzpN-0001TQ-Ri;
        Thu, 26 Jan 2023 10:49:57 +0000
Date:   Thu, 26 Jan 2023 10:49:56 +0000
From:   John Keeping <john@metanate.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-firmware@kernel.org
Subject: Re: brcm: brcmfmac4339 firmware in linux-firmware
Message-ID: <Y9Ja1CM5tgkditHK@donbot>
References: <Y72/Sd/8mMOx13lk@donbot>
 <7ffbf116-3252-8347-a621-ca9ef120e263@broadcom.com>
 <a08ccf64-652e-7ca1-2470-01514aab09ec@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a08ccf64-652e-7ca1-2470-01514aab09ec@broadcom.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jan 26, 2023 at 11:41:53AM +0100, Arend van Spriel wrote:
> On 1/26/2023 11:15 AM, Arend van Spriel wrote:
> > On 1/10/2023 8:40 PM, John Keeping wrote:
> > > That was a follow-up to commit 04f71fe ("cypress: add Cypress firmware
> > > and clm_blob files") which provides cypress/cyfmac4339-sdio.bin and
> > > links it (via WHENCE) to brcm/brcmfmac4339-sdio.bin and has version:
> > 
> > Looking into this now, but how does this work. What does that (via
> > WHENCE)? Guess I missed something fundamental here.
> 
> Assuming the copy-firmware.sh is taking care of the links.

Yes, `make install` calls copy-firmware.sh which reads the Link: lines
from WHENCE and creates the symlinks specified by those lines.


Regards,
John
