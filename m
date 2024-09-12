Return-Path: <linux-wireless+bounces-12818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB371976F96
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDF31C23C9F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236113DBBC;
	Thu, 12 Sep 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetfuse.net header.i=@jetfuse.net header.b="KtAzzfjZ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="uwjimFSm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8213FD99
	for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162268; cv=none; b=B9OPfxfeNdK2Cp3KWiVUrbU4c9ZwlpPHh85d4+vNald0oCsDccASB2GzY4XHffgOlzo8kyrbEmOSaWM9oO9QneXau0khMRkFPa1iuYL4mHcZiLNf5ygGI+jdG7x88jGxPhPj4OR7qXeqFO4ttNjm5uUAMKgIC/iOwULepAgPymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162268; c=relaxed/simple;
	bh=SNd83MDOfxlk9aCiapH/wW7QnyyLhjPHUBEZU1te800=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=honJ1dboSefeuI1x2mD4INEgx93v5WIQ6ladTxpEDXQFmehrboyOrSWJ3WYZWs57KRnmldKp5aQqB8ulawlQiV3hqJlMiVxdOEKBD2WLqQ4EGHUJGukzyVqpgzn+CjpPZCpT6XQvhMSpvUzdglx2x/rXSveE5DsKEgNkDicawSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetfuse.net; spf=pass smtp.mailfrom=jetfuse.net; dkim=pass (2048-bit key) header.d=jetfuse.net header.i=@jetfuse.net header.b=KtAzzfjZ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=uwjimFSm; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetfuse.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetfuse.net
DKIM-Signature: a=rsa-sha256; b=KtAzzfjZnwElh7FGs/c07imw6kazuKlpc+3vJiHM0Nm6E1Z4mR0zWzJUHJZ8NXs5At21Ob0UWROxGW2iwZ3e154+N6fQWUsVdbc5tRueU4Vup1JiCzkqtaP+Z2h4cR9+/IwAmfKNAiXDhJdPfj2eBCmfGwaToOC7KGaWwttQjvWZtHF+hAFdD0TzA3GT5aTqW1QCljU6Xk2UqwFxdz5JTxvEq2+26K/xd7NKI96mlwhbTMTdPNuC1oYa3+lYj/3t965lgYYXgONWMSIOOpr+DF/CbIymhwNhSC1PsNf6JeLb5VsQ2YaGjvcnuraxLPoEdRQf1EqWTTpwMC3Wqxh6ww==; s=purelymail2; d=jetfuse.net; v=1; bh=SNd83MDOfxlk9aCiapH/wW7QnyyLhjPHUBEZU1te800=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=uwjimFSmB7VQouhL7X9osZxgNAJ1cIKFR2+VQLgaQuemc0Jt6cbHz2lRVYDaOPBIMSxhmoiMGRnQ0SX+YYEDdhYUNjXGQjydEY/BVLcuC05vubcuv9JDr7QbrHRptVa3BYBn/7lGh62kN92PJCXTLrB5VasmHUwUvy1pGvJrCXDaKEN7HUJ4kTkA/vcvAikUK77gWHMbwIqQpS46WnkSiB+pqKpZNRO8CFNFtjJIQWWv0cTtOhSPjfiAKLesQrRgTTyrjMvEnFxVDgC3wN4Y53DV17jFLPOY2TWCN+RZP3BTxSktjIZg2LbYjTvkeiLcmZy8Hbmd5Pw8GfHkVq0MeQ==; s=purelymail2; d=purelymail.com; v=1; bh=SNd83MDOfxlk9aCiapH/wW7QnyyLhjPHUBEZU1te800=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 6582:1600:null:purelymail
X-Pm-Original-To: linux-wireless@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1334534472;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 12 Sep 2024 17:30:43 +0000 (UTC)
Message-ID: <576a9e32-e1cf-478f-999a-7ef3849d714e@jetfuse.net>
Date: Thu, 12 Sep 2024 12:30:42 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
To: Stanislaw Gruszka <stf_xl@wp.pl>, Ben Hutchings <ben@decadent.org.uk>
Cc: linux-wireless@vger.kernel.org,
 =?UTF-8?Q?Martin-=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
References: <ZuIhQRi/791vlUhE@decadent.org.uk> <20240912083959.GA132706@wp.pl>
Content-Language: en-US
From: Brandon Nielsen <nielsenb@jetfuse.net>
In-Reply-To: <20240912083959.GA132706@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 9/12/24 3:39 AM, Stanislaw Gruszka wrote:
> On Thu, Sep 12, 2024 at 01:01:21AM +0200, Ben Hutchings wrote:
>> iwlegacy uses command buffers with a payload size of 320
>> bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
>> describes the default buffers and there is no separate type describing
>> the huge buffers.
>>
>> The il_enqueue_hcmd() function works with both default and huge
>> buffers, and has a memcpy() to the buffer payload.  The size of
>> this copy may exceed 320 bytes when using a huge buffer, which
>> now results in a run-time warning:
>>
>>      memcpy: detected field-spanning write (size 1014) of single field "=
&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170=
 (size 320)
>>
>> To fix this:
>>
>> - Define a new struct type for huge buffers, with a correctly sized
>>    payload field
>> - When using a huge buffer in il_enqueue_hcmd(), cast the command
>>    buffer pointer to that type when looking up the payload field
>>
>> Reported-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
>> References: https://bugs.debian.org/1062421
>> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D219124
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy(=
)")
>> Tested-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
>> Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
>=20
> I proposed diffrent fix for this here:
> https://lore.kernel.org/linux-wireless/20240520073210.GA693073@wp.pl/
> but never get feedback if it works on real HW.
> So I prefer this one, sice it was tested.
>=20
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
>=20
> Martin-=C3=89ric and Brandon, could you plase also test patch from
> https://lore.kernel.org/linux-wireless/Zr2gxERA3RL3EwRe@elsanto/
> if it does not break the driver?
>=20

As far as I can tell nothing breaks with that additional patch applied.

> Thanks
> Stanislaw
>=20
>> ---
>>   drivers/net/wireless/intel/iwlegacy/common.c | 13 ++++++++++++-
>>   drivers/net/wireless/intel/iwlegacy/common.h | 12 ++++++++++++
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/=
wireless/intel/iwlegacy/common.c
>> index 9d33a66a49b5..4616293ec0cf 100644
>> --- a/drivers/net/wireless/intel/iwlegacy/common.c
>> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
>> @@ -3122,6 +3122,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host=
_cmd *cmd)
>>   =09struct il_cmd_meta *out_meta;
>>   =09dma_addr_t phys_addr;
>>   =09unsigned long flags;
>> +=09u8 *out_payload;
>>   =09u32 idx;
>>   =09u16 fix_size;
>>  =20
>> @@ -3157,6 +3158,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_hos=
t_cmd *cmd)
>>   =09out_cmd =3D txq->cmd[idx];
>>   =09out_meta =3D &txq->meta[idx];
>>  =20
>> +=09/* The payload is in the same place in regular and huge
>> +=09 * command buffers, but we need to let the compiler know when
>> +=09 * we're using a larger payload buffer to avoid "field-
>> +=09 * spanning write" warnings at run-time for huge commands.
>> +=09 */
>> +=09if (cmd->flags & CMD_SIZE_HUGE)
>> +=09=09out_payload =3D ((struct il_device_cmd_huge *)out_cmd)->cmd.paylo=
ad;
>> +=09else
>> +=09=09out_payload =3D out_cmd->cmd.payload;
>> +
>>   =09if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
>>   =09=09spin_unlock_irqrestore(&il->hcmd_lock, flags);
>>   =09=09return -ENOSPC;
>> @@ -3170,7 +3181,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host=
_cmd *cmd)
>>   =09=09out_meta->callback =3D cmd->callback;
>>  =20
>>   =09out_cmd->hdr.cmd =3D cmd->id;
>> -=09memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
>> +=09memcpy(out_payload, cmd->data, cmd->len);
>>  =20
>>   =09/* At this point, the out_cmd now has all of the incoming cmd
>>   =09 * information */
>> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/=
wireless/intel/iwlegacy/common.h
>> index 69687fcf963f..027dae5619a3 100644
>> --- a/drivers/net/wireless/intel/iwlegacy/common.h
>> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
>> @@ -560,6 +560,18 @@ struct il_device_cmd {
>>  =20
>>   #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
>>  =20
>> +/**
>> + * struct il_device_cmd_huge
>> + *
>> + * For use when sending huge commands.
>> + */
>> +struct il_device_cmd_huge {
>> +=09struct il_cmd_header hdr;=09/* uCode API */
>> +=09union {
>> +=09=09u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)];
>> +=09} __packed cmd;
>> +} __packed;
>> +
>>   struct il_host_cmd {
>>   =09const void *data;
>>   =09unsigned long reply_page;
>=20
>=20


