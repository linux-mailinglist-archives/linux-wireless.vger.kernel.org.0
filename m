Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4ED25837F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgHaV30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 17:29:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45948 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgHaV3Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 17:29:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598909364; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Type: MIME-Version: Sender;
 bh=S/W6MJIH1316lNORgWWc62+LiCFTcBERqqOm4uya8IQ=; b=sZMNnyyogcrmXYG123YvZwYsdV2ZMZo9M58HajZxxcsc3rhajOKhSpBWDYs023qIGAcEtMQB
 27BT/GMGct8+ue3j4dMWxA6FEQem92+QYUVnx4W26Y5M4+VpLLN/x9ZS74++RQeOPKgMJtkz
 kBKz+xagKV1tW2a/UWT4E0E3K/8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f4d6bb39f3347551fde02b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 21:29:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6E68C43391; Mon, 31 Aug 2020 21:29:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asinghal)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A962C433C6;
        Mon, 31 Aug 2020 21:29:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_960ed62951f7d6a649521c4bb8cbae36"
Date:   Mon, 31 Aug 2020 14:29:22 -0700
From:   asinghal@codeaurora.org
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        linux-wireless@vger.kernel.org, jouni@codeaurora.org
Subject: Re: [PATCH] cfg80211: fix 6ghz starting frequency
In-Reply-To: <11e817f5fd8b5042b281d4e575c24a8433d07d8a.camel@sipsolutions.net>
References: <1592807869-781-1-git-send-email-pradeepc@codeaurora.org>
 <ef5ead91d87183cdc02e6b5bb717b7ba@codeaurora.org>
 <11e817f5fd8b5042b281d4e575c24a8433d07d8a.camel@sipsolutions.net>
Message-ID: <fcd5f04b2a2a9f701acc00f6fcb90aac@codeaurora.org>
X-Sender: asinghal@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=_960ed62951f7d6a649521c4bb8cbae36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

hi Johannes,
             We see you accepted the attached patch. But following small 
piece is still missing, that should be applied to
the mac80211 tree, in fn. ieee80211_channel_to_freq_khz:


case NL80211_BAND_6GHZ:
		/* see 802.11ax D6.1 27.3.23.2 */
		if (chan == 2)
			return MHZ_TO_KHZ(5935);
-		if (chan <= 253)
+ 		if (chan <= 233)
			return MHZ_TO_KHZ(5950 + chan * 5);

rgds
Amar


On 2020-06-22 00:26, Johannes Berg wrote:
> On Mon, 2020-06-22 at 00:20 -0700, Pradeep Kumar Chitrapu wrote:
>> On 2020-06-21 23:37, Pradeep Kumar Chitrapu wrote:
>> > Fixes channel to frequency mappings per latest specification
>> > IEEE P802.11ax/D6.1
>> >
>> > Fixes: d1a1646c ("cfg80211: adapt to new channelization of the 6GHz
>> > band")
>> > Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
>> > ---
>> Please ignore this patch..
>> Just observed similar patch which is already in review
>> https://patchwork.kernel.org/patch/11615085/
> 
> I also already merged
> 
> https://lore.kernel.org/r/edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com
> 
> If any further changes are needed, please base them on mac80211-next...
> 
> johannes

--=_960ed62951f7d6a649521c4bb8cbae36
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=0001-cfg80211-Adjust-6-GHz-frequency-to-channel-conversio.patch
Content-Disposition: attachment;
 filename=0001-cfg80211-Adjust-6-GHz-frequency-to-channel-conversio.patch;
 size=1384

RnJvbSAyZDliNTU1MDg1NTZjY2VlNjQxMDMxMGZiOWVhMjQ4MmZkMzMyOGViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWFyIFNpbmdoYWwgPGFzaW5naGFsQGNvZGVhdXJvcmEub3Jn
PgpEYXRlOiBGcmksIDE5IEp1biAyMDIwIDEzOjUyOjAxIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
Y2ZnODAyMTE6IEFkanVzdCA2IEdIeiBmcmVxdWVuY3kgdG8gY2hhbm5lbCBjb252ZXJzaW9uCgpB
ZGp1c3QgdGhlIDYgR0h6IGZyZXF1ZW5jeSB0byBjaGFubmVsIGNvbnZlcnNpb24gZnVuY3Rpb24s
CnRoZSBvdGhlciB3YXkgYXJvdW5kIHdhcyBwcmV2aW91c2x5IGhhbmRsZWQuCgpTaWduZWQtb2Zm
LWJ5OiBBbWFyIFNpbmdoYWwgPGFzaW5naGFsQGNvZGVhdXJvcmEub3JnPgpMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzE1OTI1OTk5MjEtMTA2MDctMS1naXQtc2VuZC1lbWFpbC1hc2lu
Z2hhbEBjb2RlYXVyb3JhLm9yZwpbcmV3cml0ZSBjb21taXQgbWVzc2FnZSwgaGFyZC1jb2RlIGNo
YW5uZWwgMl0KU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVyZ0BpbnRl
bC5jb20+CgpkaWZmIC0tZ2l0IGEvbmV0L3dpcmVsZXNzL3V0aWwuYyBiL25ldC93aXJlbGVzcy91
dGlsLmMKaW5kZXggZGZhZDFjMC4uYzYyZWIzZCAxMDA2NDQKLS0tIGEvbmV0L3dpcmVsZXNzL3V0
aWwuYworKysgYi9uZXQvd2lyZWxlc3MvdXRpbC5jCkBAIC0xMjMsMTEgKzEyMywxMyBAQCBpbnQg
aWVlZTgwMjExX2ZyZXFfa2h6X3RvX2NoYW5uZWwodTMyIGZyZXEpCiAJCXJldHVybiAoZnJlcSAt
IDI0MDcpIC8gNTsKIAllbHNlIGlmIChmcmVxID49IDQ5MTAgJiYgZnJlcSA8PSA0OTgwKQogCQly
ZXR1cm4gKGZyZXEgLSA0MDAwKSAvIDU7Ci0JZWxzZSBpZiAoZnJlcSA8IDU5NDUpCisJZWxzZSBp
ZiAoZnJlcSA8IDU5MjUpCiAJCXJldHVybiAoZnJlcSAtIDUwMDApIC8gNTsKKwllbHNlIGlmIChm
cmVxID09IDU5MzUpCisJCXJldHVybiAyOwogCWVsc2UgaWYgKGZyZXEgPD0gNDUwMDApIC8qIERN
RyBiYW5kIGxvd2VyIGxpbWl0ICovCi0JCS8qIHNlZSA4MDIuMTFheCBENC4xIDI3LjMuMjIuMiAq
LwotCQlyZXR1cm4gKGZyZXEgLSA1OTQwKSAvIDU7CisJCS8qIHNlZSA4MDIuMTFheCBENi4xIDI3
LjMuMjIuMiAqLworCQlyZXR1cm4gKGZyZXEgLSA1OTUwKSAvIDU7CiAJZWxzZSBpZiAoZnJlcSA+
PSA1ODMyMCAmJiBmcmVxIDw9IDcwMjAwKQogCQlyZXR1cm4gKGZyZXEgLSA1NjE2MCkgLyAyMTYw
OwogCWVsc2UKLS0gClRoZSBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIG1l
bWJlciBvZiB0aGUgQ29kZSBBdXJvcmEgRm9ydW0sCmEgTGludXggRm91bmRhdGlvbiBDb2xsYWJv
cmF0aXZlIFByb2plY3QKCg==
--=_960ed62951f7d6a649521c4bb8cbae36--
