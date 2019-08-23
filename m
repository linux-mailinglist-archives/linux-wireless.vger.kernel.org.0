Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 618999B2E8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393839AbfHWPDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 11:03:07 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfHWPDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 11:03:07 -0400
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1M8QJq-1i5avu120G-004Qas; Fri, 23 Aug 2019 17:02:54 +0200
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Openpgp: preference=signencrypt
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr;
 prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 31/49] ath11k: add mac.c
Message-ID: <c37a9fc4-aa74-a333-a67c-cce66ad78ec0@green-communications.fr>
Date:   Fri, 23 Aug 2019 17:02:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:71/OiND/gqE/nHV30pUCzAMAIQ0jMN0g3+HhhxZkqdv9SGszeZi
 8w24mFq8Fqtuhf2fGFfACFGQwZjEiWKwvZ4WahRe8ly//a6D5Rnx43sMjlVJsnoL5MN3J7E
 vKE9ZrVF4FFAHs+EQMyRK95drapyrACTZvHyTfAq5kcm/FFMidDZ2od/oy4Wns9Kdg8TI8w
 pWzizDF5OyTjDhUcsfzDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUnsJEj8C9s=:dhwFwZ74dRCAWb4Id/nkrH
 8z/NWZB44Dwxs+UnukZPXoktXgPV665lDqZ/7xfkXho4PIOlgW9/4mtVy2pQkSNemuOxA7nQE
 sJxZmo5/wNhqVoG4VTJorPWNuoxvkw3ufBTx+cJHNWa7EFoQWoP0lgz4AfFdFKlPP+cGli+yN
 zOoLcA54exo6Ncg7IKx2Q+2Q6K9AGudsRB3iXPOeEhzoOA0x0yQ2pgBB22mET8m9WZ9395xrz
 Ka2YP4ENMJtFi+wAxTyEsCkshYKaTklin0IYgOhNmvNWPvqphmcBGUO+L7ekhhFlnayDcE5tA
 3BZ1Q7XPVXt8WeUYottdFgFjMJoDxLGDcd9+fnYBqW+9Eq0VcJVI2Lhy82swBpinvgD8jbPNY
 UaexEuvjmOoe75PizQLH/si/k2PMCwI2m3eK83j7+GbPeZet5EkxCy2i6Qf6/lOj33dAjLWeS
 sZEUeTMDwZfXPYZLvaZwqhtDgXXc/cF3cxgXZoqIyI0mVn2Lm/b23HLa7DKnTyVMy9Xo9g+mr
 wbJ48H2Lx5bcWjwNFb8p4l5UMK6+1v4awe9Q51N/oUNQ1MCkJN9NreiU6ZLX0LnVTkqJjqjtn
 2Z9vqoCuyQrDODPufnBJuut8bqs1No5aHM7ZnJ/lVT4SEC4x2p2GG6jJOnhD7LvoeFdn/fv/2
 FMYk0YBcUhw+pu09au/jnOmuTZ6Y1gnjL2AbAD9FxCjBrMqk/29kufGEbrKhU6dJd5h442Min
 DNTiwi7KQPG4PI934celwCzlDS/MMrWRRfI14SFUUoSPmNVc/08I6Za6OHgUc7v4TMn2czMGT
 bz1h67M44dBi87mSmTsjF6d0fN9Sg==
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 20/08/2019 17:47, Kalle Valo wrote:
> +	ar->hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +					 BIT(NL80211_IFTYPE_AP) |
> +					 BIT(NL80211_IFTYPE_MESH_POINT);

[...]

> +	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;

so IBSS-RSN is supported without IBSS support ?
