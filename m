Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8FAA393
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 14:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfIEM4G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 08:56:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731008AbfIEM4F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 08:56:05 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rIw-0005x7-Tq; Thu, 05 Sep 2019 15:56:03 +0300
Message-ID: <183bb8fceadadebc688bf3419321b5700df001fd.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Sep 2019 15:56:01 +0300
In-Reply-To: <87sgpdpqni.fsf@kamboji.qca.qualcomm.com>
References: <20190821133800.23636-1-luca@coelho.fi>
         <20190821133800.23636-6-luca@coelho.fi>
         <87sgpdpqni.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 05/18] iwlwifi: Set w-pointer upon resume according to SN
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-09-03 at 14:26 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Alex Malamud <alex.malamud@intel.com>
> > 
> > During D3 state, FW may send packets.
> > As a result, "write" queue pointer will be incremented by FW.
> > Upon resume from D3, driver should adjust its shadows of "write" and "read"
> > pointers to the value reported by FW.
> > 
> > 1. Keep TID used during wowlan configuration.
> > 2. Upon resume, set driver's "write" and "read" queue pointers
> > 	to the value reported by FW.
> > 
> > Signed-off-by: Alex Malamud <alex.malamud@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> A typo in the title, s/w-pointer/q-pointer/ maybe?

This means "write pointer" because that's the one that is incremented
during WoWLAN.  The feature was called update write pointer or
something, that's where it comes from.

Do you want me to reword the subject?

--
Luca.

