Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130573B0D1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jun 2023 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFWGfm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jun 2023 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWGfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jun 2023 02:35:41 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E661BCC
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 23:35:38 -0700 (PDT)
X-Halon-ID: 24eae003-1190-11ee-b7d6-cf458ee68324
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id 24eae003-1190-11ee-b7d6-cf458ee68324;
        Fri, 23 Jun 2023 08:35:34 +0200 (CEST)
From:   petter@technux.se
To:     pkshih@realtek.com
Cc:     Larry.Finger@lwfinger.net, kernel@pengutronix.de, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux@ulli-kroll.de,
        morrownr@gmail.com, petter.mabacker@esab.se, petter@technux.se,
        s.hauer@pengutronix.de
Subject: RE: Linux mainline support for RTL8811AU/RTL8821AU
Date:   Fri, 23 Jun 2023 08:35:28 +0200
Message-Id: <20230623063528.472664-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <e1d49f94865f4a69b3b3228b00697ad1@realtek.com>
References: <e1d49f94865f4a69b3b3228b00697ad1@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> -----Original Message-----
>> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
>> Sent: Wednesday, June 14, 2023 2:29 AM
>> To: petter@technux.se; linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; morrownr@gmail.com; kernel@pengutronix.de; kvalo@kernel.org;
>> linux@ulli-kroll.de; petter.mabacker@esab.se; s.hauer@pengutronix.de
>> Subject: Re: Linux mainline support for RTL8811AU/RTL8821AU
>> 
>> On 6/13/23 03:09, petter@technux.se wrote:
>> > Hi,
>> >
>> > I'm investigating a wifi dongle (LM808) that is based on the RTL8811AU chipset.
>> >
>> > $ lsusb
>> > ..
>> > Bus 003 Device 066: ID 0bda:a811 Realtek Semiconductor Corp. RTL8811AU 802.11a/b/g/n/ac WLAN Adapter
>> > ..
>> >
>> > I cannot find any driver support in mainline for that chipset (8811cu/8821cu, seems to exists). Just curious
>> if anyone knows if there are any ongoing efforts to get this driver included in mainline?
>> >
>> > I can see that both:
>> >
>> > https://www.lm-technologies.com/product/wifi-usb-adapter-433mbps-lm808/?template=driver
>> >
>> > and
>> >
>> > https://github.com/morrownr/8821au-20210708
>> >
>> > exists for non-mainline support, so will play a bit with them. But for maintenance etc I'm interested
>> to learn about possible mainline efforts within this area.
>> 
>> It seems that the RTW8821AE has never been built or released. If it had been,
>> then extending that driver to the 8821AU would be easy as there would be a file
>> rtw8821a.c that contained all the details of that chip. Without that, there is
>> little that anyone outside Realtek can do. The vendor driver, which is the one
>> in the link you posted, will likely work.
>> 

>rtlwifi can support RTL8821AE/RTL8812AE and basic USB infrastructure, so it looks
>like possible to support 8821AU by rtlwifi.
>
>Ping-Ke

So since no rtw8821a.c is available, like Larry pointed out in another response. Then it sounds like investigating
rtlwifi is the best way forward then. Do you mean that it should be possible to get the 8821AU up-and-running just by
making use of the info in ./drivers/net/wireless/realtek/rtlwifi/rtl8821ae then? Are there any plans to release a rtl8821au fw through linux-firmware, since
I guess that will be needed also.

Thanks,
Petter
