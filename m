Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8AEC2F1C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 10:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfJAIpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 04:45:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45820 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbfJAIpy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 04:45:54 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iFDmx-0000ot-89; Tue, 01 Oct 2019 11:45:44 +0300
Message-ID: <a382a59b34a35ddb2006b5820b3de5b8669d4b44.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 01 Oct 2019 11:45:41 +0300
In-Reply-To: <20191001084229.6tzdzxt53qgtehts@bars>
References: <20191001084229.6tzdzxt53qgtehts@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: ax200ngw firmware crash: where to report
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 08:42 +0000, Sergey Matyukevich wrote:
> Hello Johannes,
> 
> We are using AX1650x (200NGW) wireless card as a client for 11ax
> testing. Firmware version is 48.4fa0041f.0. Simple iperf UDP UL
> test on 100 Mbps works fine, but on 120 Mbps firmware crashes.
> 
> I would like to support bug report for this behavior. Looking
> to wireless wiki, bug reports should be submitted to Linux
> kernel bugzilla, adding linuxwifi@intel.com to recipients.
> Is this procedure still up-to-date ?

Hi Sergey,

Yes, please submit an bug report in bugzilla.  And don't forget to
attach dmesg logs.

--
Cheers,
Luca.

