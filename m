Return-Path: <linux-wireless+bounces-1926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3531882DABA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953AC1F20FCC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8A1754C;
	Mon, 15 Jan 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="MnBryDb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D617550
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:edad:0:640:6050:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTP id D12D760A6F;
	Mon, 15 Jan 2024 16:51:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4pnQGC07NqM0-LCKefKQY;
	Mon, 15 Jan 2024 16:51:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705326664; bh=6ldwEFdHm1H4WGdiYTvjBkkcSRn4QS74vxKiqlDBykc=;
	h=In-Reply-To:Subject:To:From:Cc:Date:References:Message-ID;
	b=MnBryDb1d78F3nR9FTWhN2NEFt/ijkodqeslwPzHx4pD0U4wVIlKG8dqnQQkDUky3
	 EQG6KF1F/ICRBUMlGYywx9EQjdcYbPPr1RL4MJz/Nof6sYEzlnwgi8ohta+pImtA2X
	 g9FcWwzXL395sb40/o7lRClapfT9yS9p1xBTCXeA=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <b889043b-f9ac-41d9-a910-b13adb43ba6c@yandex.ru>
Date: Mon, 15 Jan 2024 16:51:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <92f0017d-7b1d-4562-984f-885179b50435@yandex.ru>
 <dbe8a8334edc56e2488bacaeccf8474a79faae0f.camel@sipsolutions.net>
Content-Language: en-US
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 xsDNBGBYjL8BDAC1iFIjCNMSvYkyi04ln+5sTl5TCU9O5Ot/kaKKCstLq3TZ1zwsyeqF7S/q
 vBVSmkWHQaj80BlT/1m7BnFECMNV0M72+cTGfrX8edesMSzv/id+M+oe0adUeA07bBc2Rq2V
 YD88b1WgIkACQZVFCo+y7zXY64cZnf+NnI3jCPRfCKOFVwtj4OfkGZfcDAVAtxZCaksBpTHA
 tf24ay2PmV6q/QN+3IS9ZbHBs6maC1BQe6clFmpGMTvINJ032oN0Lm5ZkpNN+Xcp9393W34y
 v3aYT/OuT9eCbOxmjgMcXuERCMok72uqdhM8zkZlV85LRdW/Vy99u9gnu8Bm9UZrKTL94erm
 0A9LSI/6BLa1Qzvgwkyd2h1r6f2MVmy71/csplvaDTAqlF/4iA4TS0icC0iXDyD+Oh3EfvgP
 iEc0OAnNps/SrDWUdZbJpLtxDrSl/jXEvFW7KkW5nfYoXzjfrdb89/m7o1HozGr1ArnsMhQC
 Uo/HlX4pPHWqEAFKJ5HEa/0AEQEAAc0kRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5k
 ZXgucnU+wsEPBBMBCAA5FiEEgi6CDXNWvLfa6d7RtgcLSrzur7cFAmBYjL8FCQWjmoACGwMF
 CwkIBwIGFQgJCgsCBRYCAwEAAAoJELYHC0q87q+34CEMAKvYwHwegsKYeQokLHXeJVg/bcx9
 gVBPj88G+hcI0+3VBdsEU0M521T4zKfS6i7FYWT+mLgf35wtj/kR4akAzU3VyucUqP92t0+T
 GTvzNiJXbb4a7uxpSvV/vExfPRG/iEKxzdnNiebSe2yS4UkxsVdwXRyH5uE0mqZbDX6Muzk8
 O6h2jfzqfLSePNsxq+Sapa7CHiSQJkRiMXOHZJfXq6D+qpvnyh92hqBmrwDYZvNPmdVRIw3f
 mRFSKqSBq5J3pCKoEvAvJ6b0oyoVEwq7PoPgslJXwiuBzYhpubvSwPkdYD32Jk9CzKEF9z26
 dPSVA9l8YJ4o023lU3tTKhSOWaZy2xwE5rYHCnBs5sSshjTYNiXflYf8pjWPbQ5So0lqxfJg
 0FlMx2S8cWC7IPjfipKGof7W1DlXl1fVPs6UwCvBGkjUoSgstSZd/OcB/qIcouTmz0Pcd/jD
 nIFNw/ImUziCdCPRd8RNAddH/Fmx8R2h/DwipNp1DGY251gIJQVO3c7AzQRgWIzAAQwAyZj1
 4kk+OmXzTpV9tkUqDGDseykicFMrEE9JTdSO7fiEE4Al86IPhITKRCrjsBdQ5QnmYXcnr3/9
 i2RFI0Q7Evp0gD242jAJYgnCMXQXvWdfC55HyppWazwybDiyufW/CV3gmiiiJtUj3d8r8q6l
 aXMOGky37sRlv1UvjGyjwOxY6hBpB2oXdbpssqFOAgEw66zL54pazMOQ6g1fWmvQhUh0TpKj
 JZRGF/sib/ifBFHA/RQfAlP/jCsgnX57EOP3ALNwQqdsd5Nm1vxPqDOtKgo7e0qx3sNyk05F
 FR+f9px6eDbjE3dYfsicZd+aUOpa35EuOPXS0MC4b8SnTB6OW+pmEu/wNzWJ0vvvxX8afgPg
 lUQELheY+/bH25DnwBnWdlp45DZlz/LdancQdiRuCU77hC4fnntk2aClJh7L9Mh4J3QpBp3d
 h+vHyESFdWo5idUSNmWoPwLSYQ/evKynzeODU/afzOrDnUBEyyyPTknDxvBQZLv0q3vT0Uiq
 caL7ABEBAAHCwPwEGAEIACYWIQSCLoINc1a8t9rp3tG2BwtKvO6vtwUCYFiMwAUJBaOagAIb
 DAAKCRC2BwtKvO6vtwe/C/40zBwVFhiQTVJ5v9heTiIwfE68ZIKVnr+tq6+/z/wrRGNro4PZ
 fnqumrZtC+nD2Aj5ktNmrwlL2gTauhMT/L0tUrr287D4AHnXfZJT9fra+1NozFm7OeYkcgxh
 EG2TElxcnXSanQffA7Xx25423FD0dkh2Z5omMqH7cvmh45hBAO/6o9VltTe9T5/6mAqUjIaY
 05v2npSKsXqavaiLt4MDutgkhFCfE5PTHWEQAjnXNd0UQeBqR7/JWS55KtwsFcPvyHblW4be
 9urNPdoikGY+vF+LtIbXBgwK0qp03ivp7Ye1NcoI4n4PkGusOCD4jrzwmD18o0b31JNd2JAB
 hETgYXDi/9rBHry1xGnjzuEBalpEiTAehORU2bOVje0FBQ8Pz1C/lhyVW/wrHlW7uNqNGuop
 Pj5JUAPxMu1UKx+0KQn6HYa0bfGqstmF+d6Stj3W5VAN5J9e80MHqxg8XuXirm/6dH/mm4xc
 tx98MCutXbJWn55RtnVKbpIiMfBrcB8=
Subject: Re: mac80211: WARN_ONCE("no supported rates for sta ...")
In-Reply-To: <dbe8a8334edc56e2488bacaeccf8474a79faae0f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/25/23 16:40, Johannes Berg wrote:

> On Mon, 2023-12-25 at 14:00 +0300, Dmitry Antipov wrote:
>> I'm trying to investigate the following WARN_ONCE() observed at
>> https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d:
>>
>> ------------[ cut here ]------------
>> no supported rates for sta (null) (0xffffffff, band 1) in rate_mask 0x0 with flags 0x0
>> WARNING: CPU: 1 PID: 2875 at net/mac80211/rate.c:379 __rate_control_send_low+0x6d9/0x800 net/mac80211/rate.c:379
>> ...
>>
>> There is a (weird and completely unreadable) reproducer, the most recent one
>> https://syzkaller.appspot.com/text?tag=ReproC&x=10437de6e80000 matches 6.7.0-rc6.
>> IIUC it creates a kind of a virtual subnet of 'mac80211_hwsim' instances and then
>> enforces an attempt to setup an incorrect set of rates. Since I assume that
>> this WARN_ONCE() shouldn't happen, there might be some missing check for the
>> contents of rate-related fields of 'struct ieee80211_sub_if_data'. I've found
>> that this WARN_ONCE() may be avoided one step later by silently dropping the
>> (presumably invalid?) rate control packet in 'ieee80211_tx_h_rate_ctrl()',
>> i. e.:
>>
>> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
>> index ed4fdf655343..3ca1db6bb0fd 100644
>> --- a/net/mac80211/tx.c
>> +++ b/net/mac80211/tx.c
>> @@ -703,6 +703,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
>>           txrc.reported_rate.idx = -1;
>>           txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
>>
>> +       if (unlikely(txrc.rate_idx_mask == 0))
>> +               return TX_DROP;
>> +
>>           if (tx->sdata->rc_has_mcs_mask[info->band])
>>                   txrc.rate_idx_mcs_mask =
>>                           tx->sdata->rc_rateidx_mcs_mask[info->band];
>>
>> but most likely this is wrong and should be handled in some another
>> way somewhere else.
>>
> 
> Yeah. I'd say rate_mask 0 is the problem, but ... oh, right. I think the
> problem is that we apply the rate mask while scanning, that doesn't
> really make sense ...
> 
> If you're making a connection on 2.4 GHz (band 0) then you need not have
> a rate mask set up for 5 GHz (band 1), and so it's probably 0 by
> default, but scanning will go on that band anyway ...

I've found that the default mask for band 1 is 0xff (as set in ieee80211_if_add()):

   2139          for (i = 0; i < NUM_NL80211_BANDS; i++) {
   2140                  struct ieee80211_supported_band *sband;
   2141                  sband = local->hw.wiphy->bands[i];
   2142                  sdata->rc_rateidx_mask[i] =
   2143                          sband ? (1 << sband->n_bitrates) - 1 : 0;                /* here */

but it is changed to 0 in ieee80211_set_bitrate_mask() via the 'legacy' mask:

   3346          for (i = 0; i < NUM_NL80211_BANDS; i++) {
   3347                  struct ieee80211_supported_band *sband = wiphy->bands[i];
   3348                  int j;
   3349
   3350                  sdata->rc_rateidx_mask[i] = mask->control[i].legacy;            /* here */
   3351                  memcpy(sdata->rc_rateidx_mcs_mask[i], mask->control[i].ht_mcs,
   3352                         sizeof(mask->control[i].ht_mcs));
   3353                  memcpy(sdata->rc_rateidx_vht_mcs_mask[i],
   3354                         mask->control[i].vht_mcs,
   3355                         sizeof(mask->control[i].vht_mcs));

(IIUC this happens while handing the message comes from userspace via the
netlink socket, and this was one of the reasons to design the reproducer).
But is it acceptable at all? Shouldn't resetting the rate mask to zero disable
the corresponding band completely (including scanning)? Or should it be
prohibited to zero the default non-zero rate mask?

Dmitry


