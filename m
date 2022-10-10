Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE855FA061
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJJOon (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJJOol (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 10:44:41 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935A1035
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 07:44:38 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1665413076; bh=IxAltLphTucQjT8kmi7p/8lfTX2Y9yxUTefelUXm8jI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=P2UhtnoK8IlMyGPIhlwvylzljjZTWHG0xx7XttoOk0L1CyYUBZgzaE53zXROVjHXd
         OuLWpgkHN1tS0zXzUEQ6zZXtYmIQS12uYpKT8leWsXFS5tpeQP7HHTqnj4nsSlItLO
         Hp+559QS/LRpwmFHgMuhWA9pncWFcxhnTjEEeIyYvAQtwj4EuDLz6jNJHzJCP2iZRH
         xighLecEU1BF/R76naGqtYHD/gUi0w5DxyzzC1X7beWLsW80E6KH52FDdq8dEdrpvk
         +9FnPs3DlV1vCcGtzu3pETC0uMJlOJ2flNtbu+7lOTkmoPJBhJOAlgCfDAsuo55ocu
         wd6nwozhW0P0w==
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH v2 1/3] wifi: mac80211: add internal handler for
 wake_tx_queue
In-Reply-To: <20221009163040.25637-1-alexander@wetzel-home.de>
References: <20221009163040.25637-1-alexander@wetzel-home.de>
Date:   Mon, 10 Oct 2022 16:44:36 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1tnrb57.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> writes:

> Start to align the TX handling to only use internal TX queues (iTXQs):
>
> Provide a handler for drivers not having a custom wake_tx_queue
> callback and update the documentation.
>
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> ---
>
> This is the v2 for "wifi: mac80211: Use internal TX queues for all driver=
s"
> https://patchwork.kernel.org/project/linux-wireless/patch/20220926161303.=
13035-1-alexander@wetzel-home.de/
>
> Changes compared to V1:
>  - broken out the new wake_tx_queue handler as exported function
>  - update drivers to provide wake_tx_queue instead handling it internally
>  - Minor docu updates
>  - Some sentences of the edited docu were referring to wrong netif
>    functions. Fixed that with the edit, too.
>  - added a comment explaining why we call ieee80211_next_txq()
>  - removed now pointless checks for sta.txq

I think this version looks quite reasonable. For the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
