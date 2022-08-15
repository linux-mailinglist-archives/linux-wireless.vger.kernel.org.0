Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2C592DCE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 13:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiHOLE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 07:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiHOLEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 07:04:07 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD9A2494D
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 04:03:21 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1660561398; bh=Z/BAHXBx26U6lwshQTzavFdbtr7HzbmHONK8tFSo4Z0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QHMNqs7rj9E5bMExIjbDbH3hN8H1TdIik/bv0ztxxC7K+2J2/su8v8c0+idOdAKgE
         2ba9EMXqAsGwt/4Kk9VErZRQi7gXGNhCVv23RqiMy9xe+Lw9x2JRh9YHru5tm+YOUQ
         5h0AyB8HP53xlZpT5G0KiYggYZ6PeGfn/iXUdULIdo5h9ZDNt+yTdBFbNRnm0eF5nk
         6bwdlstPxCxaaQaYUW6zizlrsKFJLE2iKkfvBlPve4xq3YthJecp8H9k9Hjuclx2Zc
         QbSDk8kJaJqDNySRhl1LlHO0cyyixZJUOBXCwL0o8gyKFJ8ltKD0I9NG8wDGWrjRJI
         +sU4wRUPQz5Xw==
To:     Joachim Breitner <mail@joachim-breitner.de>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
In-Reply-To: <f5a35c6e83835afc114f969ee3d3f6c2003fa51b.camel@joachim-breitner.de>
References: <87ilr4hv8k.fsf@toke.dk>
 <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
 <SA1PR11MB5825CF723F193508BC04B051F2669@SA1PR11MB5825.namprd11.prod.outlook.com>
 <491ec4d63116aa51567f74004b5fba299af42029.camel@intel.com>
 <f5a35c6e83835afc114f969ee3d3f6c2003fa51b.camel@joachim-breitner.de>
Date:   Mon, 15 Aug 2022 13:03:18 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tu6d93bd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Joachim Breitner <mail@joachim-breitner.de> writes:

> Hi,
>
> Am Sonntag, dem 14.08.2022 um 14:06 +0000 schrieb Greenman, Gregory:
>> @Joachim - Can you please file a bug in kernel bugzilla, we will assign
>> someone internally to look into this.
>
> Sure thing! https://bugzilla.kernel.org/show_bug.cgi?id=216362

I already had a bz open: https://bugzilla.kernel.org/show_bug.cgi?id=215937

> Let me know if I can be of any help, giving more information or testing
> patches.

Last I heard back from Avraham he indicated that this was due to a bug
in the MEI bus driver, and asked me to reproduce with debug prints
enabled in that, which I have unfortunately not had the time to do :(

-Toke
