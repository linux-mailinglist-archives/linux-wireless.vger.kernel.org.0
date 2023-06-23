Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB08B73B089
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jun 2023 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFWGKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jun 2023 02:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFWGKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jun 2023 02:10:17 -0400
Received: from bin-mail-out-05.binero.net (bin-mail-out-05.binero.net [195.74.38.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18EA10DB
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 23:10:12 -0700 (PDT)
X-Halon-ID: 98de02d7-118c-11ee-80b4-ade5659629c7
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPSA
        id 98de02d7-118c-11ee-80b4-ade5659629c7;
        Fri, 23 Jun 2023 08:10:09 +0200 (CEST)
From:   petter@technux.se
To:     s.hauer@pengutronix.de
Cc:     Larry.Finger@lwfinger.net, andreas@fatal.se, iam@valdikss.org.ru,
        kernel@pengutronix.de, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux@ulli-kroll.de,
        petter.mabacker@esab.se, petter@technux.se, pkshih@realtek.com
Subject: Re: rtw8822cu (LM842) stalls when running HW offload scan
Date:   Fri, 23 Jun 2023 08:10:03 +0200
Message-Id: <20230623061003.472077-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616122612.GL18491@pengutronix.de>
References: <20230616122612.GL18491@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 12, 2023 at 03:30:23PM +0200, petter@technux.se wrote:
>> Some time ago https://bugzilla.kernel.org/show_bug.cgi?id=217034 was
>> created. From the beginning it was just about some error printouts.
>> Then Andreas (who created the bug report) mentioned that it seems to
>> work worse after bumping the firmware to > 9.9.10. After some fixes
>> from Sascha the error printouts dissappeared. But when I also started
>> to run this using firmware > 9.9.10 I also got problems. On my i.MX8
>> and RPi4 board it works fine, but on some of my less powerful boards
>> such as and older RPi and my i.MX6 SoloX board, it always fails using
>> 9.9.10 firmware. After some digging in the git log, I discovered
<> that HW scan offload was introduced in a later firmware. So when I
>> disable HW offload scan it seems to work again on all my boards. But
>> still I want to understand why the HW offload scan don't work for
>> me.
>> 
>> Like described in the bug report I get below when running on latest
>> 6.4 mainline with all relevant patches around rtw88 applied.

>I can't reproduce this here. I am currently running v6.4-rc3 plus:
>
>wifi: rtw88: usb: silence log flooding error message
>
>I tested on a i.MX6S (not SoloX) board with Firmware 9.9.14.
>
>A "nmcli dev wifi rescan" works just fine and the link also continues to
>work.
>
>I verified that FW_FEATURE_SCAN_OFFLOAD is set and used in the driver,
>also that it's not set in Firmware 9.9.9. I also tried to put some
>load on the link by running iperf3, still no difference.
>
>Sascha
>
Thanks for your valuable feedback, this finding made think in another direction about this.
First I tried to reproduced the issue using the same setup 6.4-rc3 + 'wifi: rtw88: usb: silence log flooding error message' but instead of using
NM, I used wpa_cli to perform the scan. This time it works fine. After some digging I realised that I had a business application still running,
that uses libnm and among other things reacts on some callback during scan. So I agree with your finding that this doesn't seems to be related to the actual HW offload scanning after all, instead it seems like using nmcli + HW offload scan + our internal application using libnm might trigger the same behavior that I reported in:

https://lore.kernel.org/linux-wireless/20230526055551.1823094-1-petter@technux.se/T/#t

I will try to do some investigations if I can use this info to find a better way to reproduce that issue. However it's still the case that I cannot reproduce above problem on for example an i.MX8 using maxcpus=1.

Thanks,
Petter
