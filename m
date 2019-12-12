Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E056711C9F9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 10:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfLLJ4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 04:56:11 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfLLJ4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 04:56:11 -0500
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1MxmBc-1hn6Py2sCk-00zBUV; Thu, 12 Dec 2019 10:56:04 +0100
To:     Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
References: <m34l02mh71.fsf@t19.piap.pl>
 <20191209102808.12014-5-nicolas.cavallari@green-communications.fr>
 <52c69792616cbf2fba7e59e25fb14cff3fc8d2db.camel@sipsolutions.net>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr;
 prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC PATCH v1 4/4] nl80211: Allow deleting stations in ibss mode
 to reset their state.
Message-ID: <b42c569a-79b0-666d-9c9a-0a8100383c6c@green-communications.fr>
Date:   Thu, 12 Dec 2019 10:56:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <52c69792616cbf2fba7e59e25fb14cff3fc8d2db.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t1dDsWL8vURvlHOnW1hdJK2TcqIFY5ft+VKKAMP9GA2Z1n0UkNC
 JJoQuDTjJxAUri9a7aaRBATfFk1oKi7ZkQI/Ar8Y+K+HXeNNFWtulNlTw1OuQehgVAWZLwm
 nIMqCzzujTksoforYKMM9zyxmtx6vM3qWXd4kFrNVCvxdSs2C4S0oZ58+PxNpNXw+PVGcXG
 NRCsfvlaZjuds3M7gcZxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8dNs19Sfeqk=:GskRqnJnOOTlWFpiQrQlmS
 GQuxVJmwLqyxze/tZ04OppDQeYySgM+r8gmG+jPcddQNkaixUH5VtdesLZG7h+fFbPGosZRgI
 hSOfAjx4dq0MED+mSC/vJycX3H7bBh6VpXqeKG8vxu3XTOBEzNuwh4hdXwfTJmrgQ5PR9AqgN
 QFbvZEqb1oeafpit12CSdPJ2uFE0PaB7tVAg8Gi0YhcYh2ilYuuYiSFapzeFYe9seE5K4uibj
 9cS1ujfOYoJ93/MwqdD1AdMD7iX9qYzJZbhfiYsi1VRCJHkn+oPOK6NsuI2FklrDXXeKZD3RQ
 nTCyp9QxAE93F54jv6Rm0iJ0Pu621nK1Kd0S4m/eJjFZp2OrAt18Yy7qrpEb14w2pnIyhvY4Q
 i9+NlJe9GppUM9pgDOFjyFXSXLxob01hF5m4jrzWrVHMP8zFd1ER7YpMfob1ZEyhS6Mtc/Mpk
 1ZDwzRdOWcg9+G3dIin7pO54RrKDYClCgwjrPOYt2Leb97jXAkCb+NkdcKHx7JVyXh5QW7U8p
 gnV+rtKEcX/eftRiuCOtjI0XkKvc+fwJ6z13BEueJ/UogH4WVOPnFOhZ0SD8iwNYC/OagQtI+
 cgfR+YPxU59Axmh4ZHBKs/Ad6q5PyLL0HpgAQdtQqDusw0PKy/ZIWaP+CqRqOIDZ0Xvpg/YQ5
 706lhfyh6zDxNdmPoYQWIwVjoLLe/utPGCOyy1bhKGKH1gtMj5rWEAYlr5mv0uUgdJuP3C0n7
 TNJX6jiCSRt3dtGlKfhVbIb+BsqkSio4HjlgR7/4ncGki+f7A0ds5sD+HRLpBbbDgEC0WQIc0
 G47ykSKQyrVaXPMy2tp862Sjt0roxTtsBDxN8+imUwxUo1n/Rf5Nvll1sjfWQflcCapBSUk2O
 j8vrGn4+zExXoEZIFQSvxLrUiBvrJus+Mz2GBMbYhdSqwlcA0iLHqTCbcuz3H1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/12/2019 22:32, Johannes Berg wrote:
> and I'm not sure, shouldn't be _that_ hard to do some kind of auth/deauth
> thing?

wpa_supplicant already does this for IBSS RSN. And it does not reset the station
for each received auth frame, the logic is more advanced than that.

(not to mention that it should switch to SAE at some point, but there is this
long standing issue of wpa_supplicant not being able to get the rsn ie of the
peer's probe response)

But for the unencrypted case, i guess simply re-reverting 52874a5e (Revert
"mac80211: in IBSS use the Auth frame to trigger STA reinsertion") and making it
conditional on !privacy should be enough ?

> That way, not only do you get visibility in userspace whether it's
> supported, but also avoid the need to change those non-mac80211 drivers
> (by having only mac80211 set the extended feature)

Ok.
