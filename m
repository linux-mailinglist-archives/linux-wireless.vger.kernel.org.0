Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43153F2C4
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 01:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiFFXuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 19:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFFXuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 19:50:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C39167F9
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 16:50:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso13954941pjg.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jun 2022 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=m/xZnKy6e6xIsp20eFP6cqg/I5yjxU5ZnJMSKjON/00=;
        b=Eky+db96+if+9FcFsju8oTkVfyDqqv09KhnE+2HVdZ9PFpmQpFE3PcJEH7BLfjtGDl
         UKmj7nBTeg0qZFtWtE2Ny1dN+fbXZfHiZzxNHs4L1MxWGimw5DMEFy12WlE3BE/OgHXp
         eQkzaQ0m9+0fsTkJLng0dbzikioFpnMv0p+ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=m/xZnKy6e6xIsp20eFP6cqg/I5yjxU5ZnJMSKjON/00=;
        b=6u9vh2AYU2XnI9TOYco+mvaNIKQaL+h+8CPDNUt7DbScs1r6pYC1YImGZgxOzd7fop
         EQ23jE4rfoyioL+EH/JDo3frljMk2WAR/Y1AnlGQsIyLovr/2VTcSdcCIzYgp9AegJ8o
         5IDJQeQkUBrO1DhMHqgmJOQOFl0njiU7rVMaUEA3AM+tbR7gmwzVQpcLmc03MuZWGYQp
         F/XukglTxTdoO5inJE1Nhc8eW9AxfDmuGLKlLIwQOu4l9dsVOtEbagNZGXgz4hK4yrjd
         MBBfoRoKkARA03eFqDNM9mymHA414RVh5FF6VJZwgzYNkc7/KU0/bD/oPl5aJVLNwBfL
         vtmg==
X-Gm-Message-State: AOAM530d/g7qknqyr4ZQAuu0nPEQWu6HleJ1SdZdPModrtAIOLPyOrg0
        bYVEQo+OgDyajqTW02fF53TK9r8dF8zunDdaC5L07MiJRxsY02QjMpmKMKP4ZmNtlLAfm+OhKfZ
        YyeXqxhtwkU3wMMQtMLmbu2g6DveY
X-Google-Smtp-Source: ABdhPJyYGXqgF+F/ibAmS0hsK2Tbpn8xHB7pn4sky5eYXRxyuYqVYUw+dm2ZEdyjhfcFwab8b1yF1g==
X-Received: by 2002:a17:90a:1544:b0:1e0:66c5:4080 with SMTP id y4-20020a17090a154400b001e066c54080mr64250796pja.141.1654559415069;
        Mon, 06 Jun 2022 16:50:15 -0700 (PDT)
Received: from smtpclient.apple ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id h11-20020a65638b000000b003f6ba49bc57sm11224748pgv.71.2022.06.06.16.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 16:50:14 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to
 firmware-crash
From:   Franky Lin <franky.lin@broadcom.com>
In-Reply-To: <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl>
Date:   Mon, 6 Jun 2022 16:50:13 -0700
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Message-Id: <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
 <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
 <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
 <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
 <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000389ca305e0d02222"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000389ca305e0d02222
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Danny,

My apology. I didn=E2=80=99t read the thread carefully and failed to notice=
 the rev1 to rev 2 change of the patch.

> On Jun 4, 2022, at 7:59 AM, Danny van Heumen <danny@dannyvanheumen.nl> wr=
ote:
>=20
> Hi Franky,
>=20
> ------- Original Message -------
> On Saturday, June 4th, 2022 at 00:58, Franky Lin <franky.lin@broadcom.com=
> wrote:
>=20
>> Hi Danny,
>>=20
>> [..]
>>=20
>> Thanks for reporting and sending out a patch to fix this.
>>=20
>> If the problem is double freeing the freezer buffer, it should be addres=
sed from the root by setting pointer to NULL. Same thing might need to be d=
one for sg table as well. Sorry I don=E2=80=99t have any sdio module to rep=
roduce and test. Please see if the below change fixes the problem.
>=20
> Your suggestion to set the freeze buffer address to zero was also my firs=
t proposal. I have since
> revised, because there are a few things I considered, although I am not s=
ure:
>=20
> - does zero-ing the address prevent future detection of double-frees with=
 the hardened memory
>  allocator? (If so, I would prefer to avoid doing this.)
> - IIUC correctly, 'sdio_set_block_size' does not do any meaningful "activ=
ation" or "allocation".
>  Therefore would not need to be *undone*. (repeated probes would override=
 previous calls)
> - Starting with the call 'sdio_enable_func', I guess/suspect more elabora=
te "cleanup" is necessary
>  therefore, leaving the 'goto out' from that point on. I would assume (fo=
r lack of evidence to the
>  contrary) that the logic at 'goto out' provides proper clean-up.

While directly return without invoking clean up process makes perfect sense=
 for the issue described here, it doesn=E2=80=99t address the broader issue=
 that sdiodev might hold on to couple stale pointers that might subsequentl=
y be used in somewhere down the path because sdiodev is not freed. Setting =
these pointer to NULL after freeing them could help us to catch such issue =
which is more catastrophic than a double-free. The perfect solution of cour=
se is to rework the code to free sdiodev whenever brcmf_sdiod_remove() is i=
nvoked but that can not be done in short-term unfortunately.

Also I forgot that our IT attached a legal footer to all emails sent to an =
external party. I am sorry about that to anyone reading my mail but there i=
s nothing I can do at the moment.

Thanks,
- Franky

>=20
> So, returning immediately with the errorcode seemed more appropriate. Reg=
ardless, I have only
> incidental knowledge from checking the code just for this particular prob=
lem. In the end my goal
> is to have the issues addressed so that I am not forced to reboot my syst=
em to get it back in
> working order.
>=20
> As for your remark about sg-table: I had not considered that, but if my n=
otes above check out,
> maybe this does not need to be treated conditionally at all.
>=20
> Kind regards,
> Danny
>=20
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b=
/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> index ac02244a6fdf..e9bad7197ba9 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>> @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brcmf_=
sdio_dev *sdiodev)
>> if (sdiodev->freezer) {
>>=20
>> WARN_ON(atomic_read(&sdiodev->freezer->freezing));
>>=20
>> kfree(sdiodev->freezer);
>>=20
>> + sdiodev->freezer =3D NULL;
>>=20
>> }
>> }
>>=20
>> @@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiod=
ev)
>> sdio_disable_func(sdiodev->func1);
>>=20
>> sdio_release_host(sdiodev->func1);
>>=20
>>=20
>> - sg_free_table(&sdiodev->sgtable);
>>=20
>> + if (sdiodev->sgtable) {
>>=20
>> + sg_free_table(&sdiodev->sgtable);
>>=20
>> + sdiodev->sgtable =3D NULL;
>>=20
>> + }
>> +
>> sdiodev->sbwad =3D 0;
>>=20
>>=20
>> pm_runtime_allow(sdiodev->func1->card->host->parent);
>>=20
>>=20
>> As for submitting patch to linux-wireless, please follow the guideline. =
[1]
>>=20
>> Thanks,
>> - Franky
>>=20
>> [1] https://www.google.com/url?q=3Dhttps://wireless.wiki.kernel.org/en/d=
evelopers/documentation/submittingpatches&source=3Dgmail-imap&ust=3D1654959=
604000000&usg=3DAOvVaw1Q6aXVZjiKkrq9qmyYVVDa




--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000389ca305e0d02222
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQZwYJKoZIhvcNAQcCoIIQWDCCEFQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2+MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUYwggQuoAMCAQICDD+oOemy/B2WnF/vHTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNDM2NDdaFw0yMjA5MDEwODAzMTBaMIGK
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xEzARBgNVBAMTCkZyYW5reSBMaW4xJjAkBgkqhkiG9w0BCQEW
F2ZyYW5reS5saW5AYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
wQl9LnrpCI0LsPyQgaFENSGK3TXA2Him11nmCkxOvfXQGEp06qSWVGhJJ4uh74eqapwDI/hBlRub
+Y9V5uX9n4UN8diL0WxhYqluRaCYBwsUdEmuGwoWN/M+3ZPVV7Zch1euKcQTB/cYWeig1oPnftVL
wMJUaEX5tSrUJh1y0INMVPIB/spvvKR4Hzlf+k29wI2TOFzPoIZRPQtWnx4OKqEx8unyGPozc9GI
kjY1BnpEEF8LCZw5w2Xi0x6RQM2QSte4iTxLzeLvVFJLJj1KtNi1VWvXYCzMuTbhLMikZHLqMxkf
4oNJJGHKt8xzvUC1Tu5vjMbOCEgQD5Ikz2gOLwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEKPgvCN0J2rCGluIqTKO+62QXKgwDQYJ
KoZIhvcNAQELBQADggEBAIlQsf/NPacuX/yG96v+J49ix14aQ6BYdmSvmuabgx/vWk/pjLsQkPBD
lW4mwEblmXeGUDOZBE494ybTSYo7XWTuFdWd1FuCipxnzMJ+WAtf7NiXW8Ayrfttq6i+4+AAjwHu
gs5HcDKeBuQEC3XVssC/06M32EuxlkCxKrQXNqYzkMJ5fdLLVPpFjjsK2fH/X2X8muS8KT4GXbUs
HGETPmDhjFb5DzuWn33x2GmWziWNQExeyehcQPFhE0rJMX6lLa2IOMLRi8FNPyb3Fa28AOyh4XOh
sQ+3AGeTN+7hJgf8DM9I47l561iQfieaicKnM/WPpmbIMuqLHbCOvgK2PFExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw/qDnpsvwdlpxf7x0wDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA6OmdTpUPRVsfvpPuTqv/jKf5Ti2L1gTwr++olY
SgyMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDYwNjIzNTAx
NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBobUj/H+BPxRDPwI12pdmv/xI3Ifu1NsdY+e7axfagLaa+hRJhhG0lbBkv
kFFd6Skz1hDLTtbzQ+BWxLTnQJRJk+5zvDlt8CwIjpnLwRjzGcrXW+HMJXCZka1C4Hd2GA4+h/Hv
KLPGXL3mH/eQZB3tO9OI+zqaPW8tDqm6yIHL61RFMSylUcSeoy8lW3refrJs3VZgd1azhmvZszXa
qPC3967W712sOtWY+rnVPZEGSDdyUFQCsrcYztj+f5o7snvkIiFsY08xlZetnvY0+bSgDTTWiX5q
AjgA6z6WV6iTgv5EXNIUfWNGfk9EqvXTtxaKXwO3Vsy7EKxT7zDYrIt7
--000000000000389ca305e0d02222--
