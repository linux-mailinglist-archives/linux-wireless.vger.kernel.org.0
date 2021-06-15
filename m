Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E0E3A8295
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhFOOVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 10:21:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhFOOTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 10:19:43 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MsIfc-1l0eLh26BO-00tj9M; Tue, 15 Jun 2021 16:17:31 +0200
To:     Johannes Berg <johannes@sipsolutions.net>,
        Abinaya Kalaiselvan <akalaise@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1618483625-31097-1-git-send-email-akalaise@codeaurora.org>
 <f7ebb34a0c01b1652defa3929559997c9885c045.camel@sipsolutions.net>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: [PATCHv2] mac80211: fix NULL ptr dereference during mesh peer
 connection for non HE devices
Message-ID: <717ff301-e29c-66d1-c0d7-5efd1b2415ba@green-communications.fr>
Date:   Tue, 15 Jun 2021 16:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f7ebb34a0c01b1652defa3929559997c9885c045.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YHeQPDNcsDqMpxhvtH+QBRxVYd7e0vSrKXQFyMWbHXXkjjIQbcm
 wu/D0ZTt1kw9shGwZ2x8R3/QwVuXifofcqr0Vrd9JDzV7wJAvSRaRsWqfU4mpqYRpbaGDA+
 iBwNuGldVuhaAat6dzRBabwZFZqumU6cqcJ/QoquF5giyC/VVXYeUgOM5KZCNBqaXqBwB4j
 Pw1B5NUqglnCpzpT+tvNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6abhCuWGEXU=:iYmO/H6AS4ROWWox/Gf24W
 aNMtDdaKUOl3NLCcQiAXKCckMXLPXlAarxbq8PKJrxsL18xaD7p12EB07VwMfTKYmEZAgS/DV
 /hCucn0uH6KBX8CdDjlagpBhkg+SP3Yh9Bg8w46U+jaotMe293gJOx8ko6iAY9EcHT2bspwMg
 sJSyslkUPnFzr8V/1uoQU8CQD4ug6i7aZ49HIsXdn1zstYC3WmgGl7LJaV2Zj7eExkh7oCepl
 CcAU8bapyVDwnEtb5Tv7r8zj300kFk+WgAKJPLRI+YErgyk5YI6K9ofJpdB+ufnbQugqcQjDI
 RC2hZQLbrYF56wuJmPf/FP3/49tALxFrllz6YomOC/UziaHOv4dGE5ynh/u6iFCtNIHwND1MQ
 6KEk7/BqPgXFZ4r+KVp5n18xajdymBs1u46wBsN7Ng7AF2/eFcmL2rv57KhNTpwXyRCEnh/2C
 1x57WvKkzFpGZCzCkRsR/slGEVAZsvxO25eQr9yiC2g3MIQn9Yo+9OKAgliR6SNM/TyQPvolh
 um+efi0S0K091OWDq7yCPp8lDWRVZBCTPGFiyvSAQrf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/04/2021 13:23, Johannes Berg wrote:
> On Thu, 2021-04-15 at 16:17 +0530, Abinaya Kalaiselvan wrote:
>> "sband->iftype_data" is not assigned with any value for non HE supported
>> devices, which causes NULL pointer access during mesh peer connection
>> in those devices. Fix this by accessing the pointer after HE
>> capabilities condition check.
>>
>> Fixes: 7f7aa94bcaf0 (mac80211: reduce peer HE MCS/NSS to own capabilities)
>> Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
>> ---
>> v2:
>> * ieee80211_sta_he_cap structure instance is initialized.
>>
> How about taking other feedback into account?
> 
> johannes
> 

I got a crash because of this bug and this patch fixes it. Abinaya, do you plan 
to submit a version with the indentation fixed, or can I do it ?
